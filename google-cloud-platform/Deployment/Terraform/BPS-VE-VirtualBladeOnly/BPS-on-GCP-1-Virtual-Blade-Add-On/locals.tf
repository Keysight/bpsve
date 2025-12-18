locals {
	AgentMachineType = var.AgentMachineType
	Agent1InstanceId = "agent1"
	AppTag = "bps"
	AppUserName = "ixia"
	File1Content = tls_private_key.SshKey.private_key_pem
	File1Name = "id_rsa"
	File2Content = tls_private_key.SshKey.public_key_openssh
	File2Name = "authorized_keys"
	File3Content = tls_private_key.SshKey.public_key_openssh
	File3Name = "id_rsa.pub"
	Preamble = replace("${local.UserLoginTag}-${local.UserProjectTag}-${local.AppTag}", "_", "-")
	Private1SubnetName = var.Private1SubnetName
	Private1VpcNetworkName = var.Private1VpcNetworkName
	Private2SubnetName = var.Private2SubnetName
	Private2VpcNetworkName = var.Private2VpcNetworkName
	PublicFirewallRuleSourceIpRanges = var.PublicFirewallRuleSourceIpRanges == null ? [ "${data.http.ip.response_body}/32" ] : var.PublicFirewallRuleSourceIpRanges
	PublicSubnetName = var.PublicSubnetName
	PublicVpcNetworkName = var.PublicVpcNetworkName
	SshKeyAlgorithm = "RSA"
	SshKeyName = "${local.Preamble}-ssh-key"
	SshKeyRsaBits = "4096"
	UserEmailTag = var.UserEmailTag == null ? "terraform@example.com" : var.UserEmailTag
	UserLoginTag = var.UserLoginTag == null ? "terraform" : var.UserLoginTag
	UserProjectTag = var.UserProjectTag == null ? lower(random_id.RandomId.id) : var.UserProjectTag
}