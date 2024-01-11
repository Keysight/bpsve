locals {
	AgentInstanceType = var.AgentInstanceType
	Agent1Eth2PrivateIpAddresses = [ "10.0.2.22", "10.0.2.23", "10.0.2.24", "10.0.2.25", "10.0.2.26", "10.0.2.27", "10.0.2.28", "10.0.2.29", "10.0.2.30", "10.0.2.31" ]
	AppTag = "bps"
	PrivateSecurityGroupName = var.PrivateSecurityGroupName
	PrivateSubnetName = var.PrivateSubnetName
	PublicSecurityGroupName = var.PublicSecurityGroupName
	PublicSubnetName = var.PublicSubnetName
	Region = data.aws_region.current.name
	UserEmailTag = var.UserEmailTag
	UserLoginTag = var.UserLoginTag
	UserProjectTag = var.UserProjectTag
}