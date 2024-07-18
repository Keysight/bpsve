module "Agent1" {
	source = "armdupre/module-bps-agent/aws"
	version = "10.0.0"
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
	depends_on = [
		module.Vpc
	]
}

resource "random_id" "RandomId" {
	byte_length = 4
}