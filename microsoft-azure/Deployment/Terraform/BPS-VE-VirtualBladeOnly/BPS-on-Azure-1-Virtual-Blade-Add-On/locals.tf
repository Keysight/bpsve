locals {
	AgentVmSize = var.AgentVmSize
	Agent1Eth0IpAddress = "10.0.10.12"
	Agent1Eth1IpAddresses = [ "10.0.2.22", "10.0.2.23", "10.0.2.24", "10.0.2.25", "10.0.2.26", "10.0.2.27", "10.0.2.28", "10.0.2.29", "10.0.2.30", "10.0.2.31" ]
	Agent1Eth2IpAddresses = [ "10.0.3.22", "10.0.3.23", "10.0.3.24", "10.0.3.25", "10.0.3.26", "10.0.3.27", "10.0.3.28", "10.0.3.29", "10.0.3.30", "10.0.3.31" ]
	Agent1InstanceId = "agent1"
	AppTag = "bps"
	AppUserName = "ixia"
	File1Content = tls_private_key.SshKey.private_key_pem
	File1Name = "id_rsa"
	File2Content = tls_private_key.SshKey.public_key_openssh
	File2Name = "authorized_keys"
	File3Content = tls_private_key.SshKey.public_key_openssh
	File3Name = "id_rsa.pub"
	Preamble = "${local.UserLoginTag}-${local.UserProjectTag}-${local.AppTag}"
	Private1SubnetName = var.Private1SubnetName
	Private2SubnetName = var.Private2SubnetName
	PublicSubnetName = var.PublicSubnetName
	ResourceGroupLocation = var.ResourceGroupLocation
	ResourceGroupName = var.ResourceGroupName == null ? "${local.Preamble}-resource-group" : var.ResourceGroupName
	SshKeyAlgorithm = "RSA"
	SshKeyName = "${local.Preamble}-ssh-key"
	SshKeyRsaBits = "4096"
	UserEmailTag = var.UserEmailTag == null ? data.azurerm_client_config.current.client_id : var.UserEmailTag
	UserLoginTag = var.UserLoginTag == null ? "terraform" : var.UserLoginTag
	UserProjectTag = var.UserProjectTag == null ? random_id.RandomId.id : var.UserProjectTag
	VnetName = var.VnetName
}