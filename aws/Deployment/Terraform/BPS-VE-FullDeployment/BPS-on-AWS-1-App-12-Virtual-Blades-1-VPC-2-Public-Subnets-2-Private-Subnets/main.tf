module "App" {
	source = "git::https://github.com/Keysight/terraform-aws-module-bps-app.git?ref=26.1.0"
	Eth0SecurityGroupId = module.Vpc.Public1SecurityGroup.id
	Eth0SubnetId = module.Vpc.Public1Subnet.id
	InstanceType = local.AppInstanceType
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	init_cli = data.cloudinit_config.init_cli.rendered
	depends_on = [
		module.Agents1,
		module.Agents2,
		module.Vpc
	]
}

module "Agents1" {
	source = "git::https://github.com/Keysight/terraform-aws-module-bps-agent.git?ref=26.1.0"
	for_each = local.agents_first_half
	Eth0PrivateIpAddress = each.value.Eth0PrivateIpAddress
	Eth0SecurityGroupId = module.Vpc.Public1SecurityGroup.id
	Eth0SubnetId = module.Vpc.Public1Subnet.id
	Eth1PrivateIpAddresses = each.value.Eth1PrivateIpAddresses
	Eth1SecurityGroupId = module.Vpc.Private1SecurityGroup.id
	Eth1SubnetId = module.Vpc.Private1Subnet.id
	Eth2PrivateIpAddresses = each.value.Eth2PrivateIpAddresses
	Eth2SecurityGroupId = module.Vpc.Private1SecurityGroup.id
	Eth2SubnetId = module.Vpc.Private1Subnet.id
	InstanceId = each.value.InstanceId
	InstanceType = local.AgentInstanceType
	PlacementGroupId = aws_placement_group.PlacementGroup1.id
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	init_cli = data.cloudinit_config.init_cli.rendered
	depends_on = [
		aws_placement_group.PlacementGroup1,
		module.Vpc
	]
}

module "Agents2" {
	source = "git::https://github.com/Keysight/terraform-aws-module-bps-agent.git?ref=26.1.0"
	for_each = local.agents_second_half
	Eth0PrivateIpAddress = each.value.Eth0PrivateIpAddress
	Eth0SecurityGroupId = module.Vpc.Public2SecurityGroup.id
	Eth0SubnetId = module.Vpc.Public2Subnet.id
	Eth1PrivateIpAddresses = each.value.Eth1PrivateIpAddresses
	Eth1SecurityGroupId = module.Vpc.Private2SecurityGroup.id
	Eth1SubnetId = module.Vpc.Private2Subnet.id
	Eth2PrivateIpAddresses = each.value.Eth2PrivateIpAddresses
	Eth2SecurityGroupId = module.Vpc.Private2SecurityGroup.id
	Eth2SubnetId = module.Vpc.Private2Subnet.id
	InstanceId = each.value.InstanceId
	InstanceType = local.AgentInstanceType
	PlacementGroupId = aws_placement_group.PlacementGroup2.id
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	init_cli = data.cloudinit_config.init_cli.rendered
	depends_on = [
		aws_placement_group.PlacementGroup2,
		module.Vpc
	]
}


resource "aws_placement_group" "PlacementGroup1" {
	name = local.PlacementGroup1Name
	strategy = local.PlacementGroupStrategy
}

resource "aws_placement_group" "PlacementGroup2" {
	name = local.PlacementGroup2Name
	strategy = local.PlacementGroupStrategy
}

resource "random_id" "RandomId" {
	byte_length = 4
}
