module "Vpc" {
	source = "git::https://github.com/Keysight/terraform-aws-module-1-vpc-2-public-subnets-2-private-subnets.git?ref=26.1.0"
	InboundIPv4CidrBlocks = local.InboundIPv4CidrBlocks
	Private1SubnetAvailabilityZone = local.Private1SubnetAvailabilityZone
	Private2SubnetAvailabilityZone = local.Private2SubnetAvailabilityZone
	Public1SubnetCidrBlock = local.Public1SubnetCidrBlock
	Public1SubnetAvailabilityZone = local.Public1SubnetAvailabilityZone
	Public2SubnetCidrBlock = local.Public2SubnetCidrBlock
	Public2SubnetAvailabilityZone = local.Public2SubnetAvailabilityZone
	Region = local.Region
	Tag = local.AppTag
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
}
