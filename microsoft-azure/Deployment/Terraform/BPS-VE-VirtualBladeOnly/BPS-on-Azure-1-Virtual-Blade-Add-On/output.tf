output "Agent1" {
	value = {
		"admin_username" : module.Agent1.Instance.admin_username
		"fqdn" : module.Agent1.Eth0PublicIpAddress.fqdn
		"name" : module.Agent1.Instance.name
		"private_ip_address" : module.Agent1.Instance.private_ip_address
		"public_ip_address" : module.Agent1.Eth0PublicIpAddress.ip_address
		"size" : module.Agent1.Instance.size
	}
}

output "ResourceGroup" {
	value = {
		"location" : data.azurerm_resource_group.ResourceGroup.location
		"name" : data.azurerm_resource_group.ResourceGroup.name
	}
}

output "SshKey" {
	sensitive = true
	value = {
		"private_key_pem" : tls_private_key.SshKey.private_key_pem
	}
}

output "Subscription" {
	sensitive   = true
	value = {
		"display_name" : data.azurerm_subscription.current.display_name
		"subscription_id" : data.azurerm_subscription.current.subscription_id
	}
}

output "Subscriptions" {
	sensitive   = true
	value = {
		"available.display_name" : data.azurerm_subscriptions.available.subscriptions[*].display_name
		"available.subscription_id" : data.azurerm_subscriptions.available.subscriptions[*].subscription_id
	}
}
