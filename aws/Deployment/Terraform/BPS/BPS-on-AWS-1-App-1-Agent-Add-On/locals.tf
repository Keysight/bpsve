locals {
	AgentInstanceType = var.AgentInstanceType
	Agent1Eth2PrivateIpAddresses = [ "10.0.2.22", "10.0.2.23", "10.0.2.24", "10.0.2.25", "10.0.2.26", "10.0.2.27", "10.0.2.28", "10.0.2.29", "10.0.2.30", "10.0.2.31" ]
	ApiMaxRetries = var.ApiMaxRetries
	AppInstanceType = var.AppInstanceType
	AppTag = "bps"
	AppUserName = "ixia"
	AwsAccessCredentialsAccessKey = var.AwsAccessCredentialsAccessKey
	AwsAccessCredentialsSecretKey = var.AwsAccessCredentialsSecretKey
	File1Content = tls_private_key.SshKey.private_key_pem
	File1Name = "id_rsa"
	File2Content = tls_private_key.SshKey.public_key_openssh
	File2Name = "authorized_keys"
	Preamble = "${local.UserLoginTag}-${local.UserProjectTag}-${local.AppTag}"
	PrivateSecurityGroupName = var.PrivateSecurityGroupName
	PrivateSubnetName = var.PrivateSubnetName
	PublicSecurityGroupName = var.PublicSecurityGroupName
	PublicSubnetName = var.PublicSubnetName
	Region = data.aws_region.current.name
	SshKeyAlgorithm = "RSA"
	SshKeyName = "${local.Preamble}-ssh-key"
	SshKeyRsaBits = "4096"
	UserEmailTag = var.UserEmailTag == null ? data.aws_caller_identity.current.user_id : var.UserEmailTag
	UserLoginTag = var.UserLoginTag == null ? "terraform" : var.UserLoginTag
	UserProjectTag = var.UserProjectTag == null ? random_id.RandomId.id : var.UserProjectTag
}