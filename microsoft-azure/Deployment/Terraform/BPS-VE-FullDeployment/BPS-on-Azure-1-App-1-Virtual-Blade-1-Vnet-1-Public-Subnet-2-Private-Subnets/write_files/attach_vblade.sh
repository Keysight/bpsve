#!/usr/bin/env bash
set -euo pipefail

# Simplified vBlade attach script
#
# Usage:
#   ./attach_vblade.sh <controller_ip> <vblade_ip> <slot_id> [username] [password]
#
# Example:
#   ./attach_vblade.sh 10.0.10.197 10.0.10.11 1 admin admin

CONTROLLER_IP="${1:?controller ip required}"
VBLADE_IP="${2:?vblade ip required}"
SLOT_ID="${3:?slot id required (1..12)}"
USERNAME="${4:-admin}"
PASSWORD="${5:-admin}"

# Build this in pieces to avoid rich-text tools turning it into an HTML anchor.
BASE="https://${CONTROLLER_IP}"

COOKIE_JAR="$(mktemp)"
trap 'rm -f "$COOKIE_JAR"' EXIT

require() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing dependency: $1" >&2
    exit 2
  }
}

require curl
require jq

json() {
  jq -nc "$@"
}

log() {
  printf '%s\n' "$*" >&2
}

is_json() {
  jq empty >/dev/null 2>&1
}

clean_url() {
  # Reads a URL-like value from stdin and prints a cleaned URL.
  # Handles normal URLs and accidental copied HTML anchor fragments.
  local raw
  raw="$(cat)"

  # Decode common HTML entity from copied rich text.
  raw="${raw//&quot;/\"}"

  # If it contains an HTML href, extract the href value.
  if [[ "$raw" == *'href="'* ]]; then
    raw="$(printf '%s\n' "$raw" | sed -n 's/.*href="\([^"]*\)".*/\1/p')"
  fi

  # Remove wrapping quotes if present.
  raw="${raw#\"}"
  raw="${raw%\"}"

  # If duplicated by visible-text anchor copy/paste, keep first URL-looking token.
  raw="$(printf '%s\n' "$raw" | sed -n 's|\(https://[^" <]*\).*|\1|p')"

  printf '%s\n' "$raw"
}

http_get() {
  curl -sk \
    -b "$COOKIE_JAR" \
    "$@"
}

http_post() {
  local payload="$1"
  local url="$2"

  curl -sk \
    -b "$COOKIE_JAR" \
    -H 'content-type: application/json' \
    -d "$payload" \
    "$url"
}

wait_https_ready() {
  local max_wait="${1:-180}"
  local interval="${2:-5}"
  local elapsed=0

  log "[pre] Probe HTTPS readiness: GET ${BASE}/"

  while true; do
    if curl -sk \
      --connect-timeout 3 \
      --max-time 5 \
      -o /dev/null \
      "${BASE}/"; then
      log "  HTTPS ready"
      return 0
    fi

    elapsed=$((elapsed + interval))

    if (( elapsed >= max_wait )); then
      log "ERROR: HTTPS not ready after ${max_wait}s"
      return 1
    fi

    log "  not ready yet; sleeping ${interval}s..."
    sleep "$interval"
  done
}

login() {
  log "[1/4] Login -> ${BASE}/bps/api/v1/auth/session"

  local payload
  local login_resp

  payload="$(
    json \
      --arg u "$USERNAME" \
      --arg p "$PASSWORD" \
      '{username:$u,password:$p,ignorePolicy:"true"}'
  )"

  login_resp="$(
    curl -sk \
      -c "$COOKIE_JAR" \
      -H 'content-type: application/json' \
      -d "$payload" \
      "${BASE}/bps/api/v1/auth/session" \
      || true
  )"

  # Some versions return empty body on successful login. That is okay.
  if [[ -n "$login_resp" ]]; then
    log "  login response:"
    log "$login_resp"
  fi

  log "  login complete"
}

poll_op_until_done() {
  # IMPORTANT:
  # This function prints only final JSON to stdout.
  # All debug logs go to stderr so callers can safely capture stdout.
  local op_url="$1"
  local max_iter="${2:-30}"
  local sleep_s="${3:-10}"

  local resp
  local progress
  local state

  for ((i=1; i<=max_iter; i++)); do
    log "  poll attempt ${i}: GET ${op_url}"

    resp="$(http_get "$op_url" || true)"

    log "  poll response:"
    log "$resp"

    if ! printf '%s\n' "$resp" | is_json; then
      log "ERROR: operation poll response was not JSON"
      return 1
    fi

    progress="$(printf '%s\n' "$resp" | jq -r '.progress // empty')"
    state="$(printf '%s\n' "$resp" | jq -r '.state // empty')"

    log "  op state=${state:-?} progress=${progress:-?}"

    if [[ "$progress" == "100" || "$state" == "COMPLETE" || "$state" == "COMPLETED" || "$state" == "SUCCESS" ]]; then
      printf '%s\n' "$resp"
      return 0
    fi

    sleep "$sleep_s"
  done

  log "ERROR: operation timed out"
  return 1
}

validate_slot() {
  log "[2/4] Validate slot=${SLOT_ID} for vBlade=${VBLADE_IP}"

  local validate_payload
  local validate_resp
  local op_url=""
  local progress=""
  local result_url=""
  local result
  local slot_status
  local slot_msg

  validate_payload="$(
    json \
      --arg ip "$VBLADE_IP" \
      --argjson slot "$SLOT_ID" \
      '[
        {
          slotId: $slot,
          ipAddress: $ip,
          status: "kNone",
          message: "",
          id: "VmDeployment.model.AssignSlots-12",
          combinedSlot: ("Slot " + ($slot|tostring))
        }
      ]'
  )"

  for attempt in {1..30}; do
    validate_resp="$(
      http_post \
        "$validate_payload" \
        "${BASE}/bps/api/v1/admin/vmdeployment/controller/validateProposedSlotValues" \
        || true
    )"

    log "--------------------------------------------------"
    log "Validate response attempt ${attempt}"
    log "--------------------------------------------------"
    log "$validate_resp"
    log "--------------------------------------------------"

    if ! printf '%s\n' "$validate_resp" | is_json; then
      log "  response was not JSON; sleeping 10s..."
      sleep 10
      continue
    fi

    op_url="$(
      printf '%s\n' "$validate_resp" |
        jq -r '.url // empty' |
        clean_url
    )"

    progress="$(
      printf '%s\n' "$validate_resp" |
        jq -r '.progress // empty'
    )"

    log "  operation url=${op_url}"
    log "  initial progress=${progress:-?}"

    if [[ -n "$op_url" && -n "$progress" ]]; then
      break
    fi

    log "  validate not ready yet; sleeping 10s..."
    sleep 10
  done

  if [[ -z "$op_url" ]]; then
    log "ERROR: validate never returned an operation URL"
    return 1
  fi

  validate_resp="$(poll_op_until_done "$op_url" 30 10)"

  result_url="$(
    printf '%s\n' "$validate_resp" |
      jq -r '.resultUrl // empty' |
      clean_url
  )"

  log "  result url=${result_url}"

  if [[ -z "$result_url" ]]; then
    log "ERROR: validate operation returned no resultUrl"
    log "$validate_resp"
    return 1
  fi

  result="$(http_get "$result_url" || true)"

  log "validation result:"
  log "$result"

  if ! printf '%s\n' "$result" | is_json; then
    log "ERROR: validation result was not JSON"
    return 1
  fi

  slot_status="$(
    printf '%s\n' "$result" |
      jq -r --argjson slot "$SLOT_ID" \
        '.[] | select(.slotId==$slot) | .status // empty'
  )"

  slot_msg="$(
    printf '%s\n' "$result" |
      jq -r --argjson slot "$SLOT_ID" \
        '.[] | select(.slotId==$slot) | .message // ""'
  )"

  if [[ "$slot_status" == "kError" ]]; then
    log "FAILED validate: slot=${SLOT_ID} msg=${slot_msg}"
    return 1
  fi

  if [[ -z "$slot_status" ]]; then
    log "ERROR: validation result did not contain slot ${SLOT_ID}"
    return 1
  fi

  log "PASSED validate: slot=${SLOT_ID} status=${slot_status}"
}

assign_slot() {
  log "[3/4] Assign -> ${BASE}/bps/api/v1/admin/vmdeployment/controller/assignSlotsToController"

  local payload
  local assign_resp

  payload="$(
    json \
      --arg ip "$VBLADE_IP" \
      --argjson slot "$SLOT_ID" \
      '[{slotId:$slot, ipAddress:$ip}]'
  )"

  assign_resp="$(
    http_post \
      "$payload" \
      "${BASE}/bps/api/v1/admin/vmdeployment/controller/assignSlotsToController" \
      || true
  )"

  if [[ -n "$assign_resp" ]]; then
    log "assign response:"
    log "$assign_resp"
  fi
}

wait_assignment() {
  log "[4/4] Wait for assignment to appear"

  local idx=$((SLOT_ID - 1))
  local resp
  local ip_now

  for i in {1..30}; do
    resp="$(
      curl -sk \
        -b "$COOKIE_JAR" \
        "${BASE}/bps/api/v1/admin/vmdeployment/controller" \
        || true
    )"

    if ! printf '%s\n' "$resp" | is_json; then
      log "  controller response was not JSON:"
      log "$resp"
      sleep 10
      continue
    fi

    ip_now="$(
      printf '%s\n' "$resp" |
        jq -r --argjson idx "$idx" '.[ $idx ].ipAddress // empty'
    )"

    if [[ "$ip_now" == "$VBLADE_IP" ]]; then
      log "PASSED attach: slot=${SLOT_ID} ip=${VBLADE_IP}"
      return 0
    fi

    log "  not yet: slot=${SLOT_ID} current=${ip_now:-<empty>}; sleeping 10s..."
    sleep 10
  done

  log "FAILED attach: slot=${SLOT_ID} did not become ${VBLADE_IP}"
  return 1
}

main() {
  wait_https_ready 180 5
  login
  validate_slot
  assign_slot
  wait_assignment
}

main "$@"
