output "Agent1" {
	value = {
		"public_address" : module.Agent1.Eth0PublicIpAddress.address
		"public_address_type" : module.Agent1.Eth0PublicIpAddress.address_type
		"image_name" : module.Agent1.Image.name
		"image_project" : module.Agent1.Image.project
		"machine_type" : module.Agent1.Instance.machine_type
		"name" : module.Agent1.Instance.name
		"network_ip" : module.Agent1.Instance.network_ip
	}
}

output "Private1VpcNetwork" {
	value = {
		"mtu" : module.Vpc.Private1VpcNetwork.mtu
		"name" : module.Vpc.Private1VpcNetwork.name
	}
}

output "Private2VpcNetwork" {
	value = {
		"mtu" : module.Vpc.Private2VpcNetwork.mtu
		"name" : module.Vpc.Private2VpcNetwork.name
	}
}

output "PublicVpcNetwork" {
	value = {
		"mtu" : module.Vpc.PublicVpcNetwork.mtu
		"name" : module.Vpc.PublicVpcNetwork.name
	}
}

output "SshKey" {
	sensitive = true
	value = {
		"private_key_pem" : tls_private_key.SshKey.private_key_pem
	}
}