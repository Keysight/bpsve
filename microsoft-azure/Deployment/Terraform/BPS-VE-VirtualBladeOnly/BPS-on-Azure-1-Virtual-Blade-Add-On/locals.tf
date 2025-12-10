locals {
	AgentVmSize = var.AgentVmSize
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