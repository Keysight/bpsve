data "azurerm_subscription" "current" {}

data "azurerm_subscriptions" "available" {}

data "azurerm_subnet" "PublicSubnet" {
	name = local.PublicSubnetName
	virtual_network_name = data.azurerm_virtual_network.Vnet.name
	resource_group_name = data.azurerm_resource_group.ResourceGroup.name
}

data "azurerm_subnet" "Private1Subnet" {
	name = local.Private1SubnetName
	virtual_network_name = data.azurerm_virtual_network.Vnet.name
	resource_group_name = data.azurerm_resource_group.ResourceGroup.name
}

data "azurerm_subnet" "Private2Subnet" {
	name = local.Private2SubnetName
	virtual_network_name = data.azurerm_virtual_network.Vnet.name
	resource_group_name = data.azurerm_resource_group.ResourceGroup.name
}

data "azurerm_virtual_network" "Vnet" {
	name = local.VnetName
	resource_group_name = data.azurerm_resource_group.ResourceGroup.name
}

data "azurerm_resource_group" "ResourceGroup" {
	name = local.ResourceGroupName
}
