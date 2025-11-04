module "App" {
	source = "git::https://github.com/armdupre/terraform-aws-module-bps-app.git?ref=11.20.0"
	Eth0SecurityGroupId = module.Vpc.PublicSecurityGroup.id
	Eth0SubnetId = module.Vpc.PublicSubnet.id
	InstanceType = local.AppInstanceType
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	init_cli = data.cloudinit_config.init_cli.rendered
	depends_on = [
		module.Vpc
	]
}

module "Agent1" {
	source = "git::https://github.com/armdupre/terraform-aws-module-bps-agent.git?ref=11.20.0"
	Eth0SecurityGroupId = module.Vpc.PublicSecurityGroup.id
	Eth0SubnetId = module.Vpc.PublicSubnet.id
	Eth1SecurityGroupId = module.Vpc.PrivateSecurityGroup.id
	Eth1SubnetId = module.Vpc.Private1Subnet.id
	Eth2SecurityGroupId = module.Vpc.PrivateSecurityGroup.id
	Eth2SubnetId = module.Vpc.Private2Subnet.id
	InstanceType = local.AgentInstanceType
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	init_cli = data.cloudinit_config.init_cli.rendered
	depends_on = [
		module.Vpc
	]
}

resource "random_id" "RandomId" {
	byte_length = 4
}