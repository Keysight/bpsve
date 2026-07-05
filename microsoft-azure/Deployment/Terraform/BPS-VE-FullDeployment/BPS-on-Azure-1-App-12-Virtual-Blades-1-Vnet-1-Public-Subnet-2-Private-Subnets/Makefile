SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c

TF_DATA_DIR := /tmp/tfdata-$(notdir $(CURDIR))
export TF_DATA_DIR

TF := time terraform
TF_FLAGS := -auto-approve

azure: all

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
	ssh -o StrictHostKeyChecking=no -i .sshkey.pem ixia@$$(terraform output -json App | jq -r .public_ip_address)

connect-agent1:
	ssh -o StrictHostKeyChecking=no -i .sshkey.pem ixia@$$(terraform output -json Agents | jq -r .Agent1.public_ip_address)

connect-agent2:
	ssh -o StrictHostKeyChecking=no -i .sshkey.pem ixia@$$(terraform output -json Agents | jq -r .Agent2.public_ip_address)

connect-agent3:
	ssh -o StrictHostKeyChecking=no -i .sshkey.pem ixia@$$(terraform output -json Agents | jq -r .Agent3.public_ip_address)

connect-agent4:
	ssh -o StrictHostKeyChecking=no -i .sshkey.pem ixia@$$(terraform output -json Agents | jq -r .Agent4.public_ip_address)

connect-agent5:
	ssh -o StrictHostKeyChecking=no -i .sshkey.pem ixia@$$(terraform output -json Agents | jq -r .Agent5.public_ip_address)

connect-agent6:
	ssh -o StrictHostKeyChecking=no -i .sshkey.pem ixia@$$(terraform output -json Agents | jq -r .Agent6.public_ip_address)

connect-agent7:
	ssh -o StrictHostKeyChecking=no -i .sshkey.pem ixia@$$(terraform output -json Agents | jq -r .Agent7.public_ip_address)

connect-agent8:
	ssh -o StrictHostKeyChecking=no -i .sshkey.pem ixia@$$(terraform output -json Agents | jq -r .Agent8.public_ip_address)

connect-agent9:
	ssh -o StrictHostKeyChecking=no -i .sshkey.pem ixia@$$(terraform output -json Agents | jq -r .Agent9.public_ip_address)

connect-agent10:
	ssh -o StrictHostKeyChecking=no -i .sshkey.pem ixia@$$(terraform output -json Agents | jq -r .Agent10.public_ip_address)

connect-agent11:
	ssh -o StrictHostKeyChecking=no -i .sshkey.pem ixia@$$(terraform output -json Agents | jq -r .Agent11.public_ip_address)

connect-agent12:
	ssh -o StrictHostKeyChecking=no -i .sshkey.pem ixia@$$(terraform output -json Agents | jq -r .Agent12.public_ip_address)
