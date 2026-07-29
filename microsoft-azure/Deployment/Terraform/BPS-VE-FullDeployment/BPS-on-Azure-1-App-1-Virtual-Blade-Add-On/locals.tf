locals {
	AgentVmSize = var.AgentVmSize
	Agent1Eth0PrivateIpAddress = "10.0.10.11"
	Agent1InstanceId = "agent1"
	AppAdminUserName = "admin"
	AppTag = "bps"
	AppUserName = "ixia"
	AppVmSize = var.AppVmSize
	File1Content = tls_private_key.SshKey.private_key_pem
	File1Name = "id_rsa"
	File2Content = tls_private_key.SshKey.public_key_openssh
	File2Name = "authorized_keys"
	File3Content = tls_private_key.SshKey.public_key_openssh
	File3Name = "id_rsa.pub"
	File4Content = file("./write_files/${local.File4Name}")
	File4Name = "attach_vblade.sh"
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
