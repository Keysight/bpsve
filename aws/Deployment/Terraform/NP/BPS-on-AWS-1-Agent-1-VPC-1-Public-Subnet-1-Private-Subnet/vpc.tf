module "Vpc" {
	source = "git::https://github.com/armdupre/terraform-aws-module-1-vpc-1-public-subnet-1-private-subnet.git?ref=11.0.0"
	InboundIPv4CidrBlocks = local.InboundIPv4CidrBlocks
	PrivateSubnetAvailabilityZone = local.PrivateSubnetAvailabilityZone
	PublicSubnetAvailabilityZone = local.PublicSubnetAvailabilityZone
	Region = local.Region
	Tag = local.AppTag
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
}