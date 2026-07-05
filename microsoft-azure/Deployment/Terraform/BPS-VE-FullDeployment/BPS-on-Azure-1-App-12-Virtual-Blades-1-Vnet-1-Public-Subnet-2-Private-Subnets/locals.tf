locals {
	AgentVmSize = var.AgentVmSize
	Agent1InstanceId = "agent1"
	AppTag = "bps"
	AppUserName = "ixia"
	AppVmSize = var.AppVmSize
	File1Content = tls_private_key.SshKey.private_key_pem
	File1Name = "id_rsa"
	File2Content = tls_private_key.SshKey.public_key_openssh
	File2Name = "authorized_keys"
	File3Content = tls_private_key.SshKey.public_key_openssh
	File3Name = "id_rsa.pub"
	Preamble = "${local.UserLoginTag}-${local.UserProjectTag}-${local.AppTag}"
	PublicSecurityRuleSourceIpPrefixes = var.PublicSecurityRuleSourceIpPrefixes == null ? [ "${data.http.ip.response_body}/32" ] : var.PublicSecurityRuleSourceIpPrefixes
	ResourceGroupLocation = var.ResourceGroupLocation
	ResourceGroupName = var.ResourceGroupName == null ? "${local.Preamble}-resource-group" : var.ResourceGroupName
	SshKeyAlgorithm = "RSA"
	SshKeyName = "${local.Preamble}-ssh-key"
	SshKeyRsaBits = "4096"
	UserEmailTag = var.UserEmailTag == null ? data.azurerm_client_config.current.client_id : var.UserEmailTag
	UserLoginTag = var.UserLoginTag == null ? "terraform" : var.UserLoginTag
	UserProjectTag = var.UserProjectTag == null ? random_id.RandomId.id : var.UserProjectTag
}

locals {
	Agents = {
		Agent1 = {
			Eth0PrivateIpAddress = "10.0.10.11"
			Eth1PrivateIpAddresses = [ "10.0.2.11", "10.0.2.12", "10.0.2.13", "10.0.2.14", "10.0.2.15", "10.0.2.16", "10.0.2.17", "10.0.2.18", "10.0.2.19", "10.0.2.20" ]
			Eth2PrivateIpAddresses = [ "10.0.3.11", "10.0.3.12", "10.0.3.13", "10.0.3.14", "10.0.3.15", "10.0.3.16", "10.0.3.17", "10.0.3.18", "10.0.3.19", "10.0.3.20" ]
			InstanceId = "agent1"
		}
		Agent2 = {
			Eth0PrivateIpAddress = "10.0.10.12"
			Eth1PrivateIpAddresses = [ "10.0.2.21", "10.0.2.22", "10.0.2.23", "10.0.2.24", "10.0.2.25", "10.0.2.26", "10.0.2.27", "10.0.2.28", "10.0.2.29", "10.0.2.30" ]
			Eth2PrivateIpAddresses = [ "10.0.3.21", "10.0.3.22", "10.0.3.23", "10.0.3.24", "10.0.3.25", "10.0.3.26", "10.0.3.27", "10.0.3.28", "10.0.3.29", "10.0.3.30" ]
			InstanceId = "agent2"
		}
		Agent3 = {
			Eth0PrivateIpAddress = "10.0.10.13"
			Eth1PrivateIpAddresses = [ "10.0.2.31", "10.0.2.32", "10.0.2.33", "10.0.2.34", "10.0.2.35", "10.0.2.36", "10.0.2.37", "10.0.2.38", "10.0.2.39", "10.0.2.40" ]
			Eth2PrivateIpAddresses = [ "10.0.3.31", "10.0.3.32", "10.0.3.33", "10.0.3.34", "10.0.3.35", "10.0.3.36", "10.0.3.37", "10.0.3.38", "10.0.3.39", "10.0.3.40" ]
			InstanceId = "agent3"
		}
		Agent4 = {
			Eth0PrivateIpAddress = "10.0.10.14"
			Eth1PrivateIpAddresses = [ "10.0.2.41", "10.0.2.42", "10.0.2.43", "10.0.2.44", "10.0.2.45", "10.0.2.46", "10.0.2.47", "10.0.2.48", "10.0.2.49", "10.0.2.50" ]
			Eth2PrivateIpAddresses = [ "10.0.3.41", "10.0.3.42", "10.0.3.43", "10.0.3.44", "10.0.3.45", "10.0.3.46", "10.0.3.47", "10.0.3.48", "10.0.3.49", "10.0.3.50" ]
			InstanceId = "agent4"
		}
		Agent5 = {
			Eth0PrivateIpAddress = "10.0.10.15"
			Eth1PrivateIpAddresses = [ "10.0.2.51", "10.0.2.52", "10.0.2.53", "10.0.2.54", "10.0.2.55", "10.0.2.56", "10.0.2.57", "10.0.2.58", "10.0.2.59", "10.0.2.60" ]
			Eth2PrivateIpAddresses = [ "10.0.3.51", "10.0.3.52", "10.0.3.53", "10.0.3.54", "10.0.3.55", "10.0.3.56", "10.0.3.57", "10.0.3.58", "10.0.3.59", "10.0.3.60" ]
			InstanceId = "agent5"
		}
		Agent6 = {
			Eth0PrivateIpAddress = "10.0.10.16"
			Eth1PrivateIpAddresses = [ "10.0.2.61", "10.0.2.62", "10.0.2.63", "10.0.2.64", "10.0.2.65", "10.0.2.66", "10.0.2.67", "10.0.2.68", "10.0.2.69", "10.0.2.70" ]
			Eth2PrivateIpAddresses = [ "10.0.3.61", "10.0.3.62", "10.0.3.63", "10.0.3.64", "10.0.3.65", "10.0.3.66", "10.0.3.67", "10.0.3.68", "10.0.3.69", "10.0.3.70" ]
			InstanceId = "agent6"
		}
		Agent7 = {
			Eth0PrivateIpAddress = "10.0.10.17"
			Eth1PrivateIpAddresses = [ "10.0.2.71", "10.0.2.72", "10.0.2.73", "10.0.2.74", "10.0.2.75", "10.0.2.76", "10.0.2.77", "10.0.2.78", "10.0.2.79", "10.0.2.80" ]
			Eth2PrivateIpAddresses = [ "10.0.3.71", "10.0.3.72", "10.0.3.73", "10.0.3.74", "10.0.3.75", "10.0.3.76", "10.0.3.77", "10.0.3.78", "10.0.3.79", "10.0.3.80" ]
			InstanceId = "agent7"
		}
		Agent8 = {
			Eth0PrivateIpAddress = "10.0.10.18"
			Eth1PrivateIpAddresses = [ "10.0.2.81", "10.0.2.82", "10.0.2.83", "10.0.2.84", "10.0.2.85", "10.0.2.86", "10.0.2.87", "10.0.2.88", "10.0.2.89", "10.0.2.90" ]
			Eth2PrivateIpAddresses = [ "10.0.3.81", "10.0.3.82", "10.0.3.83", "10.0.3.84", "10.0.3.85", "10.0.3.86", "10.0.3.87", "10.0.3.88", "10.0.3.89", "10.0.3.90" ]
			InstanceId = "agent8"
		}
		Agent9 = {
			Eth0PrivateIpAddress = "10.0.10.19"
			Eth1PrivateIpAddresses = [ "10.0.2.91", "10.0.2.92", "10.0.2.93", "10.0.2.94", "10.0.2.95", "10.0.2.96", "10.0.2.97", "10.0.2.98", "10.0.2.99", "10.0.2.100" ]
			Eth2PrivateIpAddresses = [ "10.0.3.91", "10.0.3.92", "10.0.3.93", "10.0.3.94", "10.0.3.95", "10.0.3.96", "10.0.3.97", "10.0.3.98", "10.0.3.99", "10.0.3.100" ]
			InstanceId = "agent9"
		}
		Agent10 = {
			Eth0PrivateIpAddress = "10.0.10.20"
			Eth1PrivateIpAddresses = [ "10.0.2.101", "10.0.2.102", "10.0.2.103", "10.0.2.104", "10.0.2.105", "10.0.2.106", "10.0.2.107", "10.0.2.108", "10.0.2.109", "10.0.2.110" ]
			Eth2PrivateIpAddresses = [ "10.0.3.101", "10.0.3.102", "10.0.3.103", "10.0.3.104", "10.0.3.105", "10.0.3.106", "10.0.3.107", "10.0.3.108", "10.0.3.109", "10.0.3.110" ]
			InstanceId = "agent10"
		}
		Agent11 = {
			Eth0PrivateIpAddress = "10.0.10.21"
			Eth1PrivateIpAddresses = [ "10.0.2.111", "10.0.2.112", "10.0.2.113", "10.0.2.114", "10.0.2.115", "10.0.2.116", "10.0.2.117", "10.0.2.118", "10.0.2.119", "10.0.2.120" ]
			Eth2PrivateIpAddresses = [ "10.0.3.111", "10.0.3.112", "10.0.3.113", "10.0.3.114", "10.0.3.115", "10.0.3.116", "10.0.3.117", "10.0.3.118", "10.0.3.119", "10.0.3.120" ]
			InstanceId = "agent11"
		}
		Agent12 = {
			Eth0PrivateIpAddress = "10.0.10.22"
			Eth1PrivateIpAddresses = [ "10.0.2.121", "10.0.2.122", "10.0.2.123", "10.0.2.124", "10.0.2.125", "10.0.2.216", "10.0.2.127", "10.0.2.128", "10.0.2.129", "10.0.2.130" ]
			Eth2PrivateIpAddresses = [ "10.0.3.121", "10.0.3.122", "10.0.3.123", "10.0.3.124", "10.0.3.125", "10.0.3.216", "10.0.3.127", "10.0.3.128", "10.0.3.129", "10.0.3.130" ]
			InstanceId = "agent12"
		}
	}
}
