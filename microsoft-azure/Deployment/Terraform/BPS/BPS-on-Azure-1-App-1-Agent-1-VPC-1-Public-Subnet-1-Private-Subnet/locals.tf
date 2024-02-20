locals {
	AgentVmSize = var.AgentVmSize
	Agent1Eth2IpAddresses = [ "10.0.2.22", "10.0.2.23", "10.0.2.24", "10.0.2.25", "10.0.2.26", "10.0.2.27", "10.0.2.28", "10.0.2.29", "10.0.2.30", "10.0.2.31" ]
	Agent1InstanceId = "agent1"
	AppTag = "bps"
	AppVmSize = var.AppVmSize
	PublicSecurityRuleSourceIpPrefixes = var.PublicSecurityRuleSourceIpPrefixes
	ResourceGroupLocation = var.ResourceGroupLocation
	ResourceGroupName = var.ResourceGroupName
	SharedImageGalleryName = var.SharedImageGalleryName
	SharedImageGalleryResourceGroupName = var.SharedImageGalleryResourceGroupName
	SubscriptionId = var.SubscriptionId
	UserEmailTag = var.UserEmailTag
	UserLoginTag = var.UserLoginTag
	UserProjectTag = var.UserProjectTag
}