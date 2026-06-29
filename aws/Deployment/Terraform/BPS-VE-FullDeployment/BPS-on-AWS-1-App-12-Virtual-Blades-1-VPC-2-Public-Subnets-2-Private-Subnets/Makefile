SHELL := /bin/bash
TF_DATA_DIR := /tmp/tfdata-$(notdir $(CURDIR))
export TF_DATA_DIR

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
	./CloudShell/connect.sh -i $$(terraform output -json AgentsPrivateSubnet1 | jq -r .Agent1.eth0.eip.public_ip)

connect-agent2:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -i $$(terraform output -json AgentsPrivateSubnet1 | jq -r .Agent2.eth0.eip.public_ip)

connect-agent3:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -i $$(terraform output -json AgentsPrivateSubnet1 | jq -r .Agent3.eth0.eip.public_ip)

connect-agent4:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -i $$(terraform output -json AgentsPrivateSubnet1 | jq -r .Agent4.eth0.eip.public_ip)

connect-agent5:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -i $$(terraform output -json AgentsPrivateSubnet1 | jq -r .Agent5.eth0.eip.public_ip)

connect-agent6:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -i $$(terraform output -json AgentsPrivateSubnet1 | jq -r .Agent6.eth0.eip.public_ip)

connect-agent7:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -i $$(terraform output -json AgentsPrivateSubnet2 | jq -r .Agent7.eth0.eip.public_ip)

connect-agent8:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -i $$(terraform output -json AgentsPrivateSubnet2 | jq -r .Agent8.eth0.eip.public_ip)

connect-agent9:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -i $$(terraform output -json AgentsPrivateSubnet2 | jq -r .Agent9.eth0.eip.public_ip)

connect-agent10:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -i $$(terraform output -json AgentsPrivateSubnet2 | jq -r .Agent10.eth0.eip.public_ip)

connect-agent11:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -i $$(terraform output -json AgentsPrivateSubnet2 | jq -r .Agent11.eth0.eip.public_ip)

connect-agent12:
	chmod +x ./CloudShell/connect.sh
	./CloudShell/connect.sh -i $$(terraform output -json AgentsPrivateSubnet2 | jq -r .Agent12.eth0.eip.public_ip)
