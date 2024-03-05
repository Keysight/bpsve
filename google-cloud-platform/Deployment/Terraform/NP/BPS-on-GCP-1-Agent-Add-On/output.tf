output "AgentImage" {
	value = {
		"family" : module.Agent1.Image.family
		"name" : module.Agent1.Image.name
		"project" : module.Agent1.Image.project
	}
}

output "Agent1Eth0PublicIpAddress" {
	value = {
		"address" : module.Agent1.Eth0PublicIpAddress.address
		"address_type" : module.Agent1.Eth0PublicIpAddress.address_type
	}
}