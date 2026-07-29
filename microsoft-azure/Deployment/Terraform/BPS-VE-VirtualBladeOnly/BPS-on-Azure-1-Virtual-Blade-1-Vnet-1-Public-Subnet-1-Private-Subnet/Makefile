SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c

TF_DATA_DIR := /tmp/tfdata-$(notdir $(CURDIR))
export TF_DATA_DIR

TF := time terraform
TF_FLAGS := -auto-approve

azure: all

all: apply ssh output

clean: state destroy

version:
	@echo "=== $(TF) version ==="
	$(TF) version

init:
	@echo "=== $(TF) init ==="
	$(TF) init

validate:
	@echo "=== $(TF) validate ==="
	$(TF) validate

update:
	@echo "=== $(TF) update ==="
	$(TF) get -update

plan:
	@echo "=== $(TF) plan ==="
	$(TF) plan

apply:
	@echo "=== $(TF) apply ==="
	$(TF) apply $(TF_FLAGS)

destroy:
	@echo "=== $(TF) destroy ==="
	$(TF) destroy $(TF_FLAGS)

output:
	@echo "=== $(TF) output ==="
	$(TF) output

ssh:
	@echo "=== $(TF) ssh ==="
	$(TF) output SshKey | tail -n +3 | head -n-3 | sed "s/^[ \t]*//" > .sshkey.pem
	chmod 400 .sshkey.pem

state:
	@echo "=== $(TF) state ==="
	$(TF) state list

connect-agent1:
	ssh -o StrictHostKeyChecking=no -i .sshkey.pem ixia@$$(terraform output -json Agent1 | jq -r .public_ip_address)
