module "App" {
	source = "git::https://github.com/Keysight/terraform-aws-module-bps-app.git?ref=26.0.0"
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
	source = "git::https://github.com/Keysight/terraform-aws-module-bps-agent.git?ref=26.0.0"
	Eth0SecurityGroupId = module.Vpc.PublicSecurityGroup.id
	Eth0SubnetId = module.Vpc.PublicSubnet.id
	Eth1SecurityGroupId = module.Vpc.PrivateSecurityGroup.id
	Eth1SubnetId = module.Vpc.PrivateSubnet.id
	Eth2PrivateIpAddresses = local.Agent1Eth2PrivateIpAddresses
	Eth2SecurityGroupId = module.Vpc.PrivateSecurityGroup.id
	Eth2SubnetId = module.Vpc.PrivateSubnet.id
	InstanceId = local.Agent1InstanceId
	InstanceType = local.AgentInstanceType
	PlacementGroupId = aws_placement_group.PlacementGroup.id
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	init_cli = data.cloudinit_config.init_cli.rendered
	depends_on = [
		aws_placement_group.PlacementGroup,
		module.Vpc
	]
}

resource "aws_placement_group" "PlacementGroup" {
	name = local.PlacementGroupName
	strategy = local.PlacementGroupStrategy
}

resource "random_id" "RandomId" {
	byte_length = 4
}
