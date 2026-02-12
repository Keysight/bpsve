SHELL := /bin/bash

all: init apply ssh

clean: state destroy

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
	./CloudShell/connect.sh -n $$(terraform output -json App | jq -r .name) -z $$(terraform output -json App | jq -r .zone) -p $$(terraform output -json App | jq -r .project)

connect-agent1:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -n $$(terraform output -json Agent1 | jq -r .name) -z $$(terraform output -json Agent1 | jq -r .zone) -p $$(terraform output -json Agent1 | jq -r .project)
