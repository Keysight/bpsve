module "App" {
	source = "armdupre/module-bps-app/aws"
	version = "10.0.0"
	Eth0SecurityGroupId = data.aws_security_group.PublicSecurityGroup.id
	Eth0SubnetId = data.aws_subnet.PublicSubnet.id
	Eth1SecurityGroupId = data.aws_security_group.PublicSecurityGroup.id
	Eth1SubnetId = data.aws_subnet.PublicSubnet.id
	InstanceType = local.AppInstanceType
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
}

module "Agent1" {
	source = "armdupre/module-bps-agent/aws"
	version = "10.0.0"
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
}