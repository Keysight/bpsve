SHELL := /bin/bash

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
	time terraform version

init:
	time terraform init

validate:
	time terraform validate

update:
	time terraform get -update

plan:
	time terraform plan

apply:
	time terraform apply -auto-approve

destroy:
	time terraform destroy -auto-approve

output:
	time terraform output

ssh:
	time terraform output SshKey | tail -n +3 | head -n-3 | sed "s/^[ \t]*//" > .sshkey.pem

state:
	time terraform state list

connect: connect-app

connect-app:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -i $$(terraform output -json App | jq -r .eth0.eip.public_ip)

connect-agent1:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -i $$(terraform output -json Agent1 | jq -r .eth0.eip.public_ip)
