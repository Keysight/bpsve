provider "azurerm" {
	subscription_id = var.AzureSubscriptionId
	features {}
}

locals {
	uuid = substr(uuid(), 1, 6)
	SubscriptionId = var.AzureSubscriptionId
	ResourceGroupName = var.AzureResourceGroupName
	OptionalVMPrefix = var.OptionalVMPrefix
	UserEmailTag = var.UserEmailTag
	UserProjectTag = var.UserProjectTag
	UserOptionsTag = var.UserOptionsTag
	IxiaImagesResourceGroupName = var.IxiaImagesResourceGroupName
	DiagnosticsStorageAccountName = var.DiagnosticsStorageAccountName
	VnetName = "${local.OptionalVMPrefix}_BPS_AZURE_VNET"
	VnetAddressPrefix = "10.0.0.0/16"
	MgmtSubnetName = "${local.OptionalVMPrefix}_BPS_AZURE_VNET_MGMT_SUBNET"
	MgmtSubnetPrefix = "10.0.10.0/24"
	Test1SubnetName = "${local.OptionalVMPrefix}_BPS_AZURE_VNET_TEST1_SUBNET"
	Test1SubnetPrefix = "10.0.2.0/24"
	Test2SubnetName = "${local.OptionalVMPrefix}_BPS_AZURE_VNET_TEST2_SUBNET"
	Test2SubnetPrefix = "10.0.3.0/24"
	MgmtNetworkSecurityGroupName = "${local.OptionalVMPrefix}_BPS_AZURE_NETWORK_SECURITY_GROUP"
	Test1NetworkSecurityGroupName = "${local.OptionalVMPrefix}_BPS_AZURE_TEST1_NETWORK_SECURITY_GROUP"
	Test2NetworkSecurityGroupName = "${local.OptionalVMPrefix}_BPS_AZURE_TEST2_NETWORK_SECURITY_GROUP"
	MgmtSshSecurityRuleName = "${local.OptionalVMPrefix}_BPS_AZURE_SSH_RULE"
	MgmtHttpSecurityRuleName = "${local.OptionalVMPrefix}_BPS_AZURE_WEB_RULE"
	MgmtHttpsSecurityRuleName = "${local.OptionalVMPrefix}_BPS_AZURE_HTTPS_RULE"
	MgmtSecurityRuleSourceIpPrefix = var.MgmtSecurityRuleSourceIpPrefix
	BpsSystemControllerEth0Name = "${local.OptionalVMPrefix}_BPS_AZURE_SYSTEM_CONTROLLER_ETH0"
	BpsVirtualBlade1Eth0Name = "${local.OptionalVMPrefix}_BPS_AZURE_VIRTUAL_BLADE1_ETH0"
	BpsVirtualBlade1Eth1Name = "${local.OptionalVMPrefix}_BPS_AZURE_VIRTUAL_BLADE1_ETH1"
	BpsVirtualBlade1Eth2Name = "${local.OptionalVMPrefix}_BPS_AZURE_VIRTUAL_BLADE1_ETH2"
	BpsVirtualBlade1Eth0IpAddress = "10.0.10.11"
	BpsVirtualBlade1Eth1IpAddresses = ["10.0.2.12", "10.0.2.13", "10.0.2.14", "10.0.2.15", "10.0.2.16", "10.0.2.17", "10.0.2.18", "10.0.2.19", "10.0.2.20", "10.0.2.21"]
	BpsVirtualBlade1Eth2IpAddresses = ["10.0.3.12", "10.0.3.13", "10.0.3.14", "10.0.3.15", "10.0.3.16", "10.0.3.17", "10.0.3.18", "10.0.3.19", "10.0.3.20", "10.0.3.21"]
	BpsSystemControllerName = "${local.OptionalVMPrefix}-BPS-AZURE-SYSTEM-CONTROLLER"
	BpsSystemControllerDnsLabel = join("", [lower(replace(local.ResourceGroupName, "_", "-")), "-", "bps-sys-ctrl", "-", local.uuid])
	BpsSystemControllerEnableAcceleratedNetworking = "false"
	BpsSystemControllerEnableIPForwarding = "false"
	BpsSystemControllerDisablePasswordAuthentication = "false"
	BpsSystemControllerBootDiagnosticsEnabled = "true"
	BpsSystemControllerVmSize = var.BpsSystemControllerVmSize
	BpsSystemControllerDiskSizeGB = "20"
	BpsVirtualBlade1Name = "${local.OptionalVMPrefix}-BPS-AZURE-VIRTUAL-BLADE1"
	BpsVirtualBlade1DnsLabel = join("", [lower(replace(local.ResourceGroupName, "_", "-")), "-", "bps-vblade-1", "-", local.uuid])
	BpsVirtualBladeEnableAcceleratedNetworking = "true"
	BpsVirtualBladeEnableIPForwarding = "true"
	BpsVirtualBladeDisablePasswordAuthentication = "false"
	BpsVirtualBladeBootDiagnosticsEnabled = "true"
	BpsVirtualBladeVmSize = var.BpsVirtualBladeVmSize
	BpsVirtualBladeDiskSizeGB = "14"
	MgmtPublicIpAddressName = "${local.OptionalVMPrefix}_BPS_AZURE_MGMT_PUBLIC_IP"
	BpsVirtualBlade1Eth0PublicIpAddressName = "${local.OptionalVMPrefix}_BPS_AZURE_BPS_VIRTUAL_BLADE1_ETH0_PUBLIC_IP"
	BpsSystemControllerImageName = var.BpsSystemControllerImageName
	BpsSystemControllerCreateOption = "FromImage"
	BpsSystemControllerImageId = "/subscriptions/${local.SubscriptionId}/resourceGroups/${local.IxiaImagesResourceGroupName}/providers/Microsoft.Compute/images/${local.BpsSystemControllerImageName}"
	BpsVirtualBladeImageName = var.BpsVirtualBladeImageName
	BpsVirtualBladeImageId = "/subscriptions/${local.SubscriptionId}/resourceGroups/${local.IxiaImagesResourceGroupName}/providers/Microsoft.Compute/images/${local.BpsVirtualBladeImageName}"		
	BpsVirtualBladeCreateOption = "FromImage"
	AdminUserName = "bpcloud"
	AdminPassword = "Ixia1234!"
}

resource "azurerm_resource_group" "example" {
  name = local.ResourceGroupName
  location = "East US 2"
}

resource "azurerm_virtual_network" "Vnet" {
	name = local.VnetName
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	tags = {
		Owner = local.UserEmailTag
		Project = local.UserProjectTag
		Options = local.UserOptionsTag
		ResourceGroup = azurerm_resource_group.example.name
		Location = azurerm_resource_group.example.location
	}
	address_space = [ local.VnetAddressPrefix ]
}

resource "azurerm_subnet" "MgmtSubnet" {
	name = local.MgmtSubnetName
	resource_group_name = azurerm_resource_group.example.name
	virtual_network_name = azurerm_virtual_network.Vnet.name
	address_prefixes = [ local.MgmtSubnetPrefix ]
	depends_on = [
		azurerm_virtual_network.Vnet
	]
}

resource "azurerm_subnet" "Test1Subnet" {
	name = local.Test1SubnetName
	resource_group_name = azurerm_resource_group.example.name
	virtual_network_name = azurerm_virtual_network.Vnet.name
	address_prefixes = [ local.Test1SubnetPrefix ]
	depends_on = [
		azurerm_virtual_network.Vnet
	]
}

resource "azurerm_subnet" "Test2Subnet" {
	name = local.Test2SubnetName
	resource_group_name = azurerm_resource_group.example.name
	virtual_network_name = azurerm_virtual_network.Vnet.name
	address_prefixes = [ local.Test2SubnetPrefix ]
	depends_on = [
		azurerm_virtual_network.Vnet
	]
}

resource "azurerm_network_security_group" "MgmtNetworkSecurityGroup" {
	name = local.MgmtNetworkSecurityGroupName
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	tags = {
		Owner = local.UserEmailTag
		Project = local.UserProjectTag
		Options = local.UserOptionsTag
		ResourceGroup = azurerm_resource_group.example.name
		Location = azurerm_resource_group.example.location
	}
	security_rule {
		name = local.MgmtHttpsSecurityRuleName
		description = "Allow HTTPS"
		protocol = "Tcp"
		source_port_range = "*"
		destination_port_range = "443"
		source_address_prefix = local.MgmtSecurityRuleSourceIpPrefix
		destination_address_prefix = "*"
		access = "Allow"
		priority = 100
		direction = "Inbound"
		source_address_prefixes = []
		destination_address_prefixes = []
	}
	security_rule {
		name = local.MgmtSshSecurityRuleName
		description = "Allow SSH"
		protocol = "Tcp"
		source_port_range = "*"
		destination_port_range = "22"
		source_address_prefix = local.MgmtSecurityRuleSourceIpPrefix
		destination_address_prefix = "*"
		access = "Allow"
		priority = 101
		direction = "Inbound"
		source_address_prefixes = []
		destination_address_prefixes = []
	}
	security_rule {
		name = local.MgmtHttpSecurityRuleName
		description = "Allow HTTP"
		protocol = "Tcp"
		source_port_range = "*"
		destination_port_range = "80"
		source_address_prefix = local.MgmtSecurityRuleSourceIpPrefix
		destination_address_prefix = "*"
		access = "Allow"
		priority = 102
		direction = "Inbound"
		source_address_prefixes = []
		destination_address_prefixes = []
	}
}	 

resource "azurerm_subnet_network_security_group_association" "MgmtNetworkSecurityGroup" {
	subnet_id = azurerm_subnet.MgmtSubnet.id
	network_security_group_id = azurerm_network_security_group.MgmtNetworkSecurityGroup.id
}

resource "azurerm_network_security_group" "Test1NetworkSecurityGroup" {
	name = local.Test1NetworkSecurityGroupName
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	tags = {
		Owner = local.UserEmailTag
		Project = local.UserProjectTag
		Options = local.UserOptionsTag
		ResourceGroup = azurerm_resource_group.example.name
		Location = azurerm_resource_group.example.location
	}
	security_rule {
		name = local.MgmtHttpSecurityRuleName
		description = "Allow HTTP"
		protocol = "Tcp"
		source_port_range = "*"
		destination_port_range = "80"
		source_address_prefix = local.MgmtSecurityRuleSourceIpPrefix
		destination_address_prefix = "*"
		access = "Allow"
		priority = 102
		direction = "Inbound"
		source_address_prefixes = []
		destination_address_prefixes = []
	}
} 

resource "azurerm_subnet_network_security_group_association" "Test1NetworkSecurityGroup" {
	subnet_id = azurerm_subnet.Test1Subnet.id
	network_security_group_id = azurerm_network_security_group.Test1NetworkSecurityGroup.id
}

resource "azurerm_network_security_group" "Test2NetworkSecurityGroup" {
	name = local.Test2NetworkSecurityGroupName
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	tags = {
		Owner = local.UserEmailTag
		Project = local.UserProjectTag
		Options = local.UserOptionsTag
		ResourceGroup = azurerm_resource_group.example.name
		Location = azurerm_resource_group.example.location
	}
	security_rule {
		name = local.MgmtHttpSecurityRuleName
		description = "Allow HTTP"
		protocol = "Tcp"
		source_port_range = "*"
		destination_port_range = "80"
		source_address_prefix = local.MgmtSecurityRuleSourceIpPrefix
		destination_address_prefix = "*"
		access = "Allow"
		priority = 102
		direction = "Inbound"
		source_address_prefixes = []
		destination_address_prefixes = []
	}
}

resource "azurerm_subnet_network_security_group_association" "Test2NetworkSecurityGroup" {
	subnet_id = azurerm_subnet.Test2Subnet.id
	network_security_group_id = azurerm_network_security_group.Test2NetworkSecurityGroup.id
}

resource "azurerm_network_interface" "BpsSystemControllerEth0" {
	name = local.BpsSystemControllerEth0Name
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	tags = {
		Owner = local.UserEmailTag
		Project = local.UserProjectTag
		Options = local.UserOptionsTag
		ResourceGroup = azurerm_resource_group.example.name
		Location = azurerm_resource_group.example.location
	}
	ip_configuration {
		name = "ipconfig1"
		private_ip_address_allocation = "Dynamic"
		public_ip_address_id = azurerm_public_ip.MgmtPublicIpAddress.id
		subnet_id = azurerm_subnet.MgmtSubnet.id
		primary = "true"
		private_ip_address_version = "IPv4"
	}
	dns_servers = []
	enable_accelerated_networking = local.BpsSystemControllerEnableAcceleratedNetworking
	enable_ip_forwarding = local.BpsSystemControllerEnableIPForwarding
	depends_on = [
		azurerm_subnet.MgmtSubnet,
		azurerm_network_security_group.MgmtNetworkSecurityGroup,
		azurerm_public_ip.MgmtPublicIpAddress
	]
}

resource "azurerm_network_interface" "BpsVirtualBlade1Eth0" {
	name = local.BpsVirtualBlade1Eth0Name
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	tags = {
		Owner = local.UserEmailTag
		Project = local.UserProjectTag
		Options = local.UserOptionsTag
		ResourceGroup = azurerm_resource_group.example.name
		Location = azurerm_resource_group.example.location
	}
	ip_configuration {
		name = "ipconfig1"
		private_ip_address = local.BpsVirtualBlade1Eth0IpAddress
		private_ip_address_allocation = "Static"
		public_ip_address_id = azurerm_public_ip.BpsVirtualBlade1Eth0PublicIpAddress.id
		subnet_id = azurerm_subnet.MgmtSubnet.id
		primary = "true"
		private_ip_address_version = "IPv4"
	}
	dns_servers = []
	enable_accelerated_networking = local.BpsVirtualBladeEnableAcceleratedNetworking
	enable_ip_forwarding = local.BpsVirtualBladeEnableIPForwarding
	depends_on = [
		azurerm_subnet.MgmtSubnet,
		azurerm_network_security_group.MgmtNetworkSecurityGroup,
		azurerm_public_ip.BpsVirtualBlade1Eth0PublicIpAddress
	]
}
 
resource "azurerm_network_interface" "BpsVirtualBlade1Eth1" {
	name = local.BpsVirtualBlade1Eth1Name
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	tags = {
		Owner = local.UserEmailTag
		Project = local.UserProjectTag
		Options = local.UserOptionsTag
		ResourceGroup = azurerm_resource_group.example.name
		Location = azurerm_resource_group.example.location
	}
	ip_configuration {
		name = "ipconfig1"
		private_ip_address = local.BpsVirtualBlade1Eth1IpAddresses[0]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test1Subnet.id
		primary = "true"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig2"
		private_ip_address = local.BpsVirtualBlade1Eth1IpAddresses[1]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test1Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig3"
		private_ip_address = local.BpsVirtualBlade1Eth1IpAddresses[2]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test1Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig4"
		private_ip_address = local.BpsVirtualBlade1Eth1IpAddresses[3]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test1Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig5"
		private_ip_address = local.BpsVirtualBlade1Eth1IpAddresses[4]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test1Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig6"
		private_ip_address = local.BpsVirtualBlade1Eth1IpAddresses[5]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test1Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig7"
		private_ip_address = local.BpsVirtualBlade1Eth1IpAddresses[6]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test1Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig8"
		private_ip_address = local.BpsVirtualBlade1Eth1IpAddresses[7]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test1Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig9"
		private_ip_address = local.BpsVirtualBlade1Eth1IpAddresses[8]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test1Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfigA"
		private_ip_address = local.BpsVirtualBlade1Eth1IpAddresses[9]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test1Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	dns_servers = []
	enable_accelerated_networking = local.BpsVirtualBladeEnableAcceleratedNetworking
	enable_ip_forwarding = local.BpsVirtualBladeEnableIPForwarding
	depends_on = [
		azurerm_subnet.Test1Subnet,
		azurerm_network_security_group.Test1NetworkSecurityGroup
	]
}
 
resource "azurerm_network_interface" "BpsVirtualBlade1Eth2" {
	name = local.BpsVirtualBlade1Eth2Name
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	tags = {
		Owner = local.UserEmailTag
		Project = local.UserProjectTag
		Options = local.UserOptionsTag
		ResourceGroup = azurerm_resource_group.example.name
		Location = azurerm_resource_group.example.location
	}
	ip_configuration {
		name = "ipconfig1"
		private_ip_address = local.BpsVirtualBlade1Eth2IpAddresses[0]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test2Subnet.id
		primary = "true"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig2"
		private_ip_address = local.BpsVirtualBlade1Eth2IpAddresses[1]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test2Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig3"
		private_ip_address = local.BpsVirtualBlade1Eth2IpAddresses[2]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test2Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig4"
		private_ip_address = local.BpsVirtualBlade1Eth2IpAddresses[3]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test2Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig5"
		private_ip_address = local.BpsVirtualBlade1Eth2IpAddresses[4]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test2Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig6"
		private_ip_address = local.BpsVirtualBlade1Eth2IpAddresses[5]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test2Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig7"
		private_ip_address = local.BpsVirtualBlade1Eth2IpAddresses[6]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test2Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig8"
		private_ip_address = local.BpsVirtualBlade1Eth2IpAddresses[7]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test2Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfig9"
		private_ip_address = local.BpsVirtualBlade1Eth2IpAddresses[8]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test2Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	ip_configuration {
		name = "ipconfigA"
		private_ip_address = local.BpsVirtualBlade1Eth2IpAddresses[9]
		private_ip_address_allocation = "Static"
		subnet_id = azurerm_subnet.Test2Subnet.id
		primary = "false"
		private_ip_address_version = "IPv4"
	}
	dns_servers = []
	enable_accelerated_networking = local.BpsVirtualBladeEnableAcceleratedNetworking
	enable_ip_forwarding = local.BpsVirtualBladeEnableIPForwarding
	depends_on = [
		azurerm_subnet.Test2Subnet,
		azurerm_network_security_group.Test2NetworkSecurityGroup
	]
}

resource "azurerm_public_ip" "MgmtPublicIpAddress" {
	name = local.MgmtPublicIpAddressName
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	tags = {
		Owner = local.UserEmailTag
		Project = local.UserProjectTag
		Options = local.UserOptionsTag
		ResourceGroup = azurerm_resource_group.example.name
		Location = azurerm_resource_group.example.location
	}
	ip_version = "IPv4"
	allocation_method = "Static"
	idle_timeout_in_minutes = 4
	domain_name_label = local.BpsSystemControllerDnsLabel
}

resource "azurerm_public_ip" "BpsVirtualBlade1Eth0PublicIpAddress" {
	name = local.BpsVirtualBlade1Eth0PublicIpAddressName
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	tags = {
		Owner = local.UserEmailTag
		Project = local.UserProjectTag
		Options = local.UserOptionsTag
		ResourceGroup = azurerm_resource_group.example.name
		Location = azurerm_resource_group.example.location
	}
	ip_version = "IPv4"
	allocation_method = "Static"
	idle_timeout_in_minutes = 4
	domain_name_label = local.BpsVirtualBlade1DnsLabel
}

resource "azurerm_virtual_machine" "BpsSystemController" {
	name = local.BpsSystemControllerName
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	tags = {
		Owner = local.UserEmailTag
		Project = local.UserProjectTag
		Options = local.UserOptionsTag
		ResourceGroup = azurerm_resource_group.example.name
		Location = azurerm_resource_group.example.location
	}
	vm_size = local.BpsSystemControllerVmSize
	storage_image_reference {
		id = local.BpsSystemControllerImageId
	}
	storage_os_disk {
		os_type = "Linux"
		name = "disk_${local.BpsSystemControllerName}"
		create_option = local.BpsSystemControllerCreateOption
		caching = "ReadWrite"
		disk_size_gb = local.BpsSystemControllerDiskSizeGB
	}
	os_profile {
		computer_name = local.BpsSystemControllerName
		admin_username = local.AdminUserName
		admin_password = local.AdminPassword
	}
	os_profile_linux_config {
		disable_password_authentication = local.BpsSystemControllerDisablePasswordAuthentication
	}
	network_interface_ids = [
		azurerm_network_interface.BpsSystemControllerEth0.id
	]
	boot_diagnostics {
		enabled = local.BpsSystemControllerBootDiagnosticsEnabled
		storage_uri = "https://${local.DiagnosticsStorageAccountName}.blob.core.windows.net/"
	}
	depends_on = [
		azurerm_network_interface.BpsSystemControllerEth0
	]
	timeouts {
		create = "10m"
		delete = "20m"
	}
}

resource "azurerm_virtual_machine" "BpsVirtualBlade1" {
	name = local.BpsVirtualBlade1Name
	location = azurerm_resource_group.example.location
	resource_group_name = azurerm_resource_group.example.name
	tags = {
		Owner = local.UserEmailTag
		Project = local.UserProjectTag
		Options = local.UserOptionsTag
		ResourceGroup = azurerm_resource_group.example.name
		Location = azurerm_resource_group.example.location
	}
	vm_size = local.BpsVirtualBladeVmSize
	storage_image_reference {
		id = local.BpsVirtualBladeImageId
	}
	storage_os_disk {
		os_type = "Linux"
		name = "disk_${local.BpsVirtualBlade1Name}"
		create_option = local.BpsVirtualBladeCreateOption
		caching = "ReadWrite"
		disk_size_gb = local.BpsVirtualBladeDiskSizeGB
	}
	os_profile {
		computer_name = local.BpsVirtualBlade1Name
		admin_username = local.AdminUserName
		admin_password = local.AdminPassword
	}
	os_profile_linux_config {
		disable_password_authentication = local.BpsVirtualBladeDisablePasswordAuthentication
	}
	primary_network_interface_id = azurerm_network_interface.BpsVirtualBlade1Eth0.id
	network_interface_ids = [
		azurerm_network_interface.BpsVirtualBlade1Eth0.id,
		azurerm_network_interface.BpsVirtualBlade1Eth1.id,
		azurerm_network_interface.BpsVirtualBlade1Eth2.id
	]
	boot_diagnostics {
		enabled = local.BpsVirtualBladeBootDiagnosticsEnabled
		storage_uri = "https://${local.DiagnosticsStorageAccountName}.blob.core.windows.net/"
	}
	depends_on = [
		azurerm_network_interface.BpsVirtualBlade1Eth0,
		azurerm_network_interface.BpsVirtualBlade1Eth1,
		azurerm_network_interface.BpsVirtualBlade1Eth2
	]
	timeouts {
		create = "10m"
		delete = "20m"
	}
}