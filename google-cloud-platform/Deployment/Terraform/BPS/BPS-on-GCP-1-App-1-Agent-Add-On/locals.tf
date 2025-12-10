locals {
	AgentMachineType = var.AgentMachineType
	Agent1InstanceId = "agent1"
	AppMachineType = var.AppMachineType
	AppTag = "bps"
	AppUserName = "ixia"
	File1Content = tls_private_key.SshKey.private_key_pem
	File1Name = "id_rsa"
	File2Content = tls_private_key.SshKey.public_key_openssh
	File2Name = "authorized_keys"
	Preamble = "${local.UserLoginTag}-${local.UserProjectTag}-${local.AppTag}"
	Private1SubnetName = var.Private1SubnetName
	Private1VpcNetworkName = var.Private1VpcNetworkName
	Private2SubnetName = var.Private2SubnetName
	Private2VpcNetworkName = var.Private2VpcNetworkName
	PublicFirewallRuleSourceIpRanges = var.PublicFirewallRuleSourceIpRanges
	PublicSubnetName = var.PublicSubnetName
	PublicVpcNetworkName = var.PublicVpcNetworkName
	SshKeyAlgorithm = "RSA"
	SshKeyName = "${local.Preamble}-ssh-key"
	SshKeyRsaBits = "4096"
	UserEmailTag = var.UserEmailTag
	UserLoginTag = var.UserLoginTag
	UserProjectTag = var.UserProjectTag
}