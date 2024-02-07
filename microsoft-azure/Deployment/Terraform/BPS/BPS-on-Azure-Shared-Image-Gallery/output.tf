output "SharedImageGallery" {
	value = {
		"location" = module.SharedImageGallery.SharedImageGallery.location
		"name" = module.SharedImageGallery.SharedImageGallery.name
		"resource_group_name" = module.SharedImageGallery.SharedImageGallery.resource_group_name
		"sharing_permission" = module.SharedImageGallery.SharedImageGallery.sharing_permission
		"sharing_community_gallery" = module.SharedImageGallery.SharedImageGallery.sharing_community_gallery
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