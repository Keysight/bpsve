locals {
	AgentInstanceType = var.AgentInstanceType
	ApiMaxRetries = var.ApiMaxRetries
	AppInstanceType = var.AppInstanceType
	AppTag = "bps"
	AppUserName = "ixia"
	AwsAccessCredentialsAccessKey = var.AwsAccessCredentialsAccessKey
	AwsAccessCredentialsSecretKey = var.AwsAccessCredentialsSecretKey
	InboundIPv4CidrBlocks = var.InboundIPv4CidrBlocks == null ? [ "${data.http.ip.response_body}/32" ] : var.InboundIPv4CidrBlocks
	File1Content = tls_private_key.SshKey.private_key_pem
	File1Name = "id_rsa"
	File2Content = tls_private_key.SshKey.public_key_openssh
	File2Name = "authorized_keys"
	File3Content = tls_private_key.SshKey.public_key_openssh
	File3Name = "id_rsa.pub"
	PlacementGroupStrategy = "cluster"
	PlacementGroup1Name = "${local.Preamble}-placement-group-1-${local.Region}"
	PlacementGroup2Name = "${local.Preamble}-placement-group-2-${local.Region}"
	Preamble = "${local.UserLoginTag}-${local.UserProjectTag}-${local.AppTag}"
	Private1SubnetAvailabilityZone = var.Private1SubnetAvailabilityZone
	Private2SubnetAvailabilityZone = var.Private2SubnetAvailabilityZone
	Public1SubnetAvailabilityZone = var.Public1SubnetAvailabilityZone
	Public1SubnetCidrBlock = var.Public1SubnetCidrBlock
	Public2SubnetAvailabilityZone = var.Public2SubnetAvailabilityZone
	Public2SubnetCidrBlock = var.Public2SubnetCidrBlock
	Region = data.aws_region.current.region
	SshKeyAlgorithm = "RSA"
	SshKeyName = "${local.Preamble}-ssh-key"
	SshKeyRsaBits = "4096"
	UserEmailTag = var.UserEmailTag == null ? data.aws_caller_identity.current.user_id : var.UserEmailTag
	UserLoginTag = var.UserLoginTag == null ? "terraform" : var.UserLoginTag
	UserProjectTag = var.UserProjectTag == null ? random_id.RandomId.id : var.UserProjectTag
}

locals {
	Agents = {
		Agent1 = {
			Eth0PrivateIpAddress = "10.0.10.11"
			Eth1PrivateIpAddresses = [ "10.0.2.11" ]
			Eth2PrivateIpAddresses = [ "10.0.2.21" ]
			InstanceId = "agent1"
		}
		Agent2 = {
			Eth0PrivateIpAddress = "10.0.10.12"
			Eth1PrivateIpAddresses = [ "10.0.2.12" ]
			Eth2PrivateIpAddresses = [ "10.0.2.22" ]
			InstanceId = "agent2"
		}
		Agent3 = {
			Eth0PrivateIpAddress = "10.0.10.13"
			Eth1PrivateIpAddresses = [ "10.0.2.13" ]
			Eth2PrivateIpAddresses = [ "10.0.2.23" ]
			InstanceId = "agent3"
		}
		Agent4 = {
			Eth0PrivateIpAddress = "10.0.10.14"
			Eth1PrivateIpAddresses = [ "10.0.2.14" ]
			Eth2PrivateIpAddresses = [ "10.0.2.24" ]
			InstanceId = "agent4"
		}
		Agent5 = {
			Eth0PrivateIpAddress = "10.0.10.15"
			Eth1PrivateIpAddresses = [ "10.0.2.15" ]
			Eth2PrivateIpAddresses = [ "10.0.2.25" ]
			InstanceId = "agent5"
		}
		Agent6 = {
			Eth0PrivateIpAddress = "10.0.10.16"
			Eth1PrivateIpAddresses = [ "10.0.2.16" ]
			Eth2PrivateIpAddresses = [ "10.0.2.26" ]
			InstanceId = "agent6"
		}
		Agent7 = {
			Eth0PrivateIpAddress = "10.0.11.11"
			Eth1PrivateIpAddresses = [ "10.0.3.11" ]
			Eth2PrivateIpAddresses = [ "10.0.3.21" ]
			InstanceId = "agent7"
		}
		Agent8 = {
			Eth0PrivateIpAddress = "10.0.11.12"
			Eth1PrivateIpAddresses = [ "10.0.3.12" ]
			Eth2PrivateIpAddresses = [ "10.0.3.22" ]
			InstanceId = "agent8"
		}
		Agent9 = {
			Eth0PrivateIpAddress = "10.0.11.13"
			Eth1PrivateIpAddresses = [ "10.0.3.13" ]
			Eth2PrivateIpAddresses = [ "10.0.3.23" ]
			InstanceId = "agent9"
		}
		Agent10 = {
			Eth0PrivateIpAddress = "10.0.11.14"
			Eth1PrivateIpAddresses = [ "10.0.3.14" ]
			Eth2PrivateIpAddresses = [ "10.0.3.24" ]
			InstanceId = "agent10"
		}
		Agent11 = {
			Eth0PrivateIpAddress = "10.0.11.15"
			Eth1PrivateIpAddresses = [ "10.0.3.15" ]
			Eth2PrivateIpAddresses = [ "10.0.3.25" ]
			InstanceId = "agent11"
		}
		Agent12 = {
			Eth0PrivateIpAddress = "10.0.11.16"
			Eth1PrivateIpAddresses = [ "10.0.3.16" ]
			Eth2PrivateIpAddresses = [ "10.0.3.26" ]
			InstanceId = "agent12"
		}
	}
}

locals {
  # Decorate keys with numeric suffix and sortable key
  agents_decorated = [
    for k in keys(local.Agents) : {
      key = k
      n   = tonumber(regex("^Agent(\\d+)$", k)[0])
      sk  = format("%06d", tonumber(regex("^Agent(\\d+)$", k)[0]))
    }
  ]

  # Sorted keys in numeric order: Agent1, Agent2, ... Agent10
  agent_keys_sorted = [
    for sk in sort(local.agents_decorated[*].sk) :
    one([for o in local.agents_decorated : o.key if o.sk == sk])
  ]

  total = length(local.agent_keys_sorted)
  mid   = ceil(local.total / 2)

  first_keys  = slice(local.agent_keys_sorted, 0, local.mid)
  second_keys = slice(local.agent_keys_sorted, local.mid, local.total)

  # Rebuild two maps for for_each
  agents_first_half  = { for k in local.first_keys  : k => local.Agents[k] }
  agents_second_half = { for k in local.second_keys : k => local.Agents[k] }
}
