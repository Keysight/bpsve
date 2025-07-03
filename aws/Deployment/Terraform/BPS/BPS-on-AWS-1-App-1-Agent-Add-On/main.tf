module "App" {
	source = "git::https://github.com/armdupre/terraform-aws-module-bps-app.git?ref=11.0.0"
	Eth0SecurityGroupId = data.aws_security_group.PublicSecurityGroup.id
	Eth0SubnetId = data.aws_subnet.PublicSubnet.id
	InstanceType = local.AppInstanceType
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	init_cli = data.cloudinit_config.init_cli.rendered
}

module "Agent1" {
	source = "git::https://github.com/armdupre/terraform-aws-module-bps-agent.git?ref=11.0.0"
	Eth0SecurityGroupId = data.aws_security_group.PublicSecurityGroup.id
	Eth0SubnetId = data.aws_subnet.PublicSubnet.id
	Eth1SecurityGroupId = data.aws_security_group.PrivateSecurityGroup.id
	Eth1SubnetId = data.aws_subnet.PrivateSubnet.id
	Eth2PrivateIpAddresses = local.Agent1Eth2PrivateIpAddresses
	Eth2SecurityGroupId = data.aws_security_group.PrivateSecurityGroup.id
	Eth2SubnetId = data.aws_subnet.PrivateSubnet.id
	InstanceType = local.AgentInstanceType
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	init_cli = data.cloudinit_config.init_cli.rendered
}

resource "random_id" "RandomId" {
	byte_length = 4
}