module "Agent1" {
	source = "armdupre/module-bps-agent/azurerm"
	version = "10.0.1"
	Eth0SubnetId = module.Vnet.PublicSubnet.id
	Eth1SubnetId = module.Vnet.Private1Subnet.id
	Eth2SubnetId = module.Vnet.Private2Subnet.id
	InstanceId = local.Agent1InstanceId
	ResourceGroupLocation = azurerm_resource_group.ResourceGroup.location
	ResourceGroupName = azurerm_resource_group.ResourceGroup.name
	SharedImageGalleryName = local.SharedImageGalleryName
	SharedImageGalleryResourceGroupName = local.SharedImageGalleryResourceGroupName
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	VmSize = local.AgentVmSize
	depends_on = [
		module.Vnet
	]
}

resource "azurerm_resource_group" "ResourceGroup" {
	name = local.ResourceGroupName
	location = local.ResourceGroupLocation
}