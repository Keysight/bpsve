module "Agent1" {
	source = "git::https://github.com/armdupre/terraform-aws-module-bps-agent.git?ref=11.0.0"
	Eth0SecurityGroupId = module.Vpc.PublicSecurityGroup.id
	Eth0SubnetId = module.Vpc.PublicSubnet.id
	Eth1SecurityGroupId = module.Vpc.PrivateSecurityGroup.id
	Eth1SubnetId = module.Vpc.PrivateSubnet.id
	Eth2PrivateIpAddresses = local.Agent1Eth2PrivateIpAddresses
	Eth2SecurityGroupId = module.Vpc.PrivateSecurityGroup.id
	Eth2SubnetId = module.Vpc.PrivateSubnet.id
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