module "Agent1" {
	source = "git::https://github.com/armdupre/terraform-azurerm-module-bps-agent.git?ref=11.20.0"
	Eth0SubnetId = module.Vnet.PublicSubnet.id
	Eth1SubnetId = module.Vnet.Private1Subnet.id
	Eth2SubnetId = module.Vnet.Private2Subnet.id
	InstanceId = local.Agent1InstanceId
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