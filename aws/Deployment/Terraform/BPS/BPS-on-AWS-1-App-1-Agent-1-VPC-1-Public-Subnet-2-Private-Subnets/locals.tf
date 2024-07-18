locals {
	AgentInstanceType = var.AgentInstanceType
	AppInstanceType = var.AppInstanceType
	AppTag = "bps"
	InboundIPv4CidrBlocks = var.InboundIPv4CidrBlocks == null ? [ "${data.http.ip.response_body}/32" ] : var.InboundIPv4CidrBlocks
	Private1SubnetAvailabilityZone = var.Private1SubnetAvailabilityZone
	Private2SubnetAvailabilityZone = var.Private2SubnetAvailabilityZone
	PublicSubnetAvailabilityZone = var.PublicSubnetAvailabilityZone
	Region = data.aws_region.current.name
	UserEmailTag = var.UserEmailTag == null ? data.aws_caller_identity.current.user_id : var.UserEmailTag
	UserLoginTag = var.UserLoginTag == null ? "terraform" : var.UserLoginTag
	UserProjectTag = var.UserProjectTag == null ? random_id.RandomId.id : var.UserProjectTag
}