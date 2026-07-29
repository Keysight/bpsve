SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c

TF_DATA_DIR := /tmp/tfdata-$(notdir $(CURDIR))
export TF_DATA_DIR

TF := time terraform
TF_FLAGS := -auto-approve

gcp: all

all: init apply ssh

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

connect: connect-app

connect-app:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -n $$(terraform output -json App | jq -r .name) -z $$(terraform output -json App | jq -r .zone) -p $$(terraform output -json App | jq -r .project)

connect-agent1:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -n $$(terraform output -json Agent1 | jq -r .name) -z $$(terraform output -json Agent1 | jq -r .zone) -p $$(terraform output -json Agent1 | jq -r .project)
