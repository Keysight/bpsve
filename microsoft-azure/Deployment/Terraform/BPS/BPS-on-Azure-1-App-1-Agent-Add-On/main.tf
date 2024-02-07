module "App" {
	source = "armdupre/module-bps-app/azurerm"
	version = "9.30.2"
	Eth0SubnetId = data.azurerm_subnet.PublicSubnet.id
	ResourceGroupLocation = data.azurerm_resource_group.ResourceGroup.location
	ResourceGroupName = data.azurerm_resource_group.ResourceGroup.name
	SharedImageGalleryName = local.SharedImageGalleryName
	SharedImageGalleryResourceGroupName = local.SharedImageGalleryResourceGroupName
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	VmSize = local.AppVmSize
	depends_on = [
		module.Agent1
	]
}

module "Agent1" {
	source = "armdupre/module-bps-agent/azurerm"
	version = "9.30.2"
	Eth0SubnetId = data.azurerm_subnet.PublicSubnet.id
	Eth1SubnetId = data.azurerm_subnet.Private1Subnet.id
	Eth2SubnetId = data.azurerm_subnet.Private2Subnet.id
	InstanceId = local.Agent1InstanceId
	ResourceGroupLocation = data.azurerm_resource_group.ResourceGroup.location
	ResourceGroupName = data.azurerm_resource_group.ResourceGroup.name
	SharedImageGalleryName = local.SharedImageGalleryName
	SharedImageGalleryResourceGroupName = local.SharedImageGalleryResourceGroupName
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	VmSize = local.AgentVmSize
}