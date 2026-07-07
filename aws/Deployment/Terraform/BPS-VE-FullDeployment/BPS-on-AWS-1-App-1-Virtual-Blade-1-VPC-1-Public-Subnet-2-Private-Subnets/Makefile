SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c

TF_DATA_DIR := /tmp/tfdata-$(notdir $(CURDIR))
export TF_DATA_DIR

TF := time terraform
TF_FLAGS := -auto-approve

aws: install all

all: init apply ssh output

clean: state destroy

install:
ifeq ($(shell grep "^ID=" /etc/*elease | cut -d "=" -f 2| sed -e 's/^"//' -e 's/"$$//' 2> /dev/null), amzn)
ifeq ($(shell command -v terraform 2> /dev/null),)
	sudo yum install -y yum-utils
	sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
	sudo yum -y install terraform
endif
endif

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
	./CloudShell/connect.sh -i $$(terraform output -json App | jq -r .eth0.eip.public_ip)

connect-agent1:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -i $$(terraform output -json Agent1 | jq -r .eth0.eip.public_ip)
