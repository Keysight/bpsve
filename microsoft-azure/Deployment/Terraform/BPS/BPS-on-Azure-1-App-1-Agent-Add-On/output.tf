output "Agent1Eth0PublicIpAddress" {
	value = {
		"fqdn" : module.Agent1.Eth0PublicIpAddress.fqdn
		"ip_address" : module.Agent1.Eth0PublicIpAddress.ip_address
	}
}

output "AppEth0PublicIpAddress" {
	value = {
		"fqdn" : module.App.Eth0PublicIpAddress.fqdn
		"ip_address" : module.App.Eth0PublicIpAddress.ip_address
	}
}

output "ResourceGroup" {
	value = {
		"location" : data.azurerm_resource_group.ResourceGroup.location
		"name" : data.azurerm_resource_group.ResourceGroup.name
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