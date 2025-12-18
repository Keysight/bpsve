#!/usr/bin/env bash
# Install Google Cloud CLI (gcloud) on Ubuntu 24.04+ using the official APT repo
# - Uses keyring (no apt-key deprecation)
# - Installs google-cloud-cli (includes gsutil, bq, alpha/beta commands)
# - Optionally installs kubectl via APT
# - Runs gcloud init at the end

set -euo pipefail

log() { printf "\033[1;32m[*]\033[0m %s\n" "$*"; }
warn(){ printf "\033[1;33m[!]\033[0m %s\n" "$*"; }
err() { printf "\033[1;31m[x]\033[0m %s\n" "$*" >&2; }

# 1) Prereqs
log "Installing prerequisites..."
sudo apt update
sudo apt install -y apt-transport-https ca-certificates gnupg curl

# 2) Official Google Cloud APT repo (with keyring)
REPO_LIST="/etc/apt/sources.list.d/google-cloud-cli.list"
KEYRING="/usr/share/keyrings/cloud.google.gpg"

log "Adding Google Cloud CLI repository..."
echo "deb [signed-by=${KEYRING}] https://packages.cloud.google.com/apt cloud-sdk main" | \
  sudo tee "${REPO_LIST}" >/dev/null

log "Importing Google Cloud public key into keyring..."
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
  sudo gpg --dearmor -o "${KEYRING}"

# 3) Install CLI
log "Installing google-cloud-cli..."
sudo apt update
sudo apt install -y google-cloud-cli

# Optionally install kubectl via APT (comment out if you prefer gcloud components)
if ! command -v kubectl >/dev/null 2>&1; then
  log "Installing kubectl via APT (optional)..."
  sudo apt install -y kubectl || warn "kubectl APT install failed; you can later run: gcloud components install kubectl"
fi

## 4) Verify
log "Verifying installation..."
gcloud --version || err "gcloud not found on PATH"

# 5) Initialize
log "Starting gcloud init (browser auth + default project/region/zone)..."
gcloud init

