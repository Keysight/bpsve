data "azurerm_client_config" "current" { }

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

data "cloudinit_config" "init_cli" {
	gzip = false
	base64_encode = false
	part {
		content_type = "text/cloud-config"
		content = templatefile("cloud-init.yml", {
			File1Content : local.File1Content
			File1Name : local.File1Name
			File2Content : local.File2Content
			File2Name : local.File2Name
			File3Content : local.File3Content
			File3Name : local.File3Name
			UserName: local.AppUserName
		})
	}
}