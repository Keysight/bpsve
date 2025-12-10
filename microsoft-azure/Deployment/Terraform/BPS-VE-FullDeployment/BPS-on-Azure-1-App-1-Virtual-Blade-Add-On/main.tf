module "App" {
	source = "git::https://github.com/armdupre/terraform-azurerm-module-bps-app.git?ref=11.20.0"
	Eth0SubnetId = data.azurerm_subnet.PublicSubnet.id
	ResourceGroupLocation = data.azurerm_resource_group.ResourceGroup.location
	ResourceGroupName = data.azurerm_resource_group.ResourceGroup.name
	SshKeyName = azurerm_ssh_public_key.SshKey.name
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	VmSize = local.AppVmSize
	init_cli = data.cloudinit_config.init_cli.rendered
	depends_on = [
		azurerm_ssh_public_key.SshKey,
		module.Agent1
	]
}

module "Agent1" {
	source = "git::https://github.com/armdupre/terraform-azurerm-module-bps-agent.git?ref=11.20.1"
	Eth0SubnetId = data.azurerm_subnet.PublicSubnet.id
	Eth1SubnetId = data.azurerm_subnet.Private1Subnet.id
	Eth2SubnetId = data.azurerm_subnet.Private2Subnet.id
	InstanceId = local.Agent1InstanceId
	ResourceGroupLocation = data.azurerm_resource_group.ResourceGroup.location
	ResourceGroupName = data.azurerm_resource_group.ResourceGroup.name
	SshKeyName = azurerm_ssh_public_key.SshKey.name
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	VmSize = local.AgentVmSize
	init_cli = data.cloudinit_config.init_cli.rendered
	depends_on = [
		azurerm_ssh_public_key.SshKey
	]
}

resource "random_id" "RandomId" {
	byte_length = 4
}