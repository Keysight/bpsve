module "App" {
	source = "git::https://github.com/Keysight/terraform-azurerm-module-bps-app.git?ref=26.1.0"
	Eth0SubnetId = module.Vnet.PublicSubnet.id
	ResourceGroupLocation = azurerm_resource_group.ResourceGroup.location
	ResourceGroupName = azurerm_resource_group.ResourceGroup.name
	SshKeyName = azurerm_ssh_public_key.SshKey.name
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	VmSize = local.AppVmSize
	init_cli = data.cloudinit_config.init_cli.rendered
	depends_on = [
		azurerm_ssh_public_key.SshKey,
		module.Agents,
		module.Vnet
	]
}

module "Agents" {
	source = "git::https://github.com/Keysight/terraform-azurerm-module-bps-agent.git?ref=26.1.0"
	for_each = local.Agents
	Eth0IpAddress = each.value.Eth0PrivateIpAddress
	Eth0SubnetId = module.Vnet.PublicSubnet.id
	Eth1IpAddresses = each.value.Eth1PrivateIpAddresses
	Eth1SubnetId = module.Vnet.Private1Subnet.id
	Eth2IpAddresses = each.value.Eth2PrivateIpAddresses
	Eth2SubnetId = module.Vnet.Private2Subnet.id
	InstanceId = each.value.InstanceId
	ResourceGroupLocation = azurerm_resource_group.ResourceGroup.location
	ResourceGroupName = azurerm_resource_group.ResourceGroup.name
	SshKeyName = azurerm_ssh_public_key.SshKey.name
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	VmSize = local.AgentVmSize
	init_cli = data.cloudinit_config.init_cli.rendered
	depends_on = [
		azurerm_ssh_public_key.SshKey,
		module.Vnet
	]
}

resource "azurerm_resource_group" "ResourceGroup" {
	name = local.ResourceGroupName
	location = local.ResourceGroupLocation
}

resource "random_id" "RandomId" {
	byte_length = 4
}
