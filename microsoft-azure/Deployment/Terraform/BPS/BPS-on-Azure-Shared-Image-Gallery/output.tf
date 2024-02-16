output "AgentSharedImage" {
	value = {
		"accelerated_network_support_enabled" : module.SharedImageGallery.AgentSharedImage.accelerated_network_support_enabled
		"architecture" : module.SharedImageGallery.AgentSharedImage.architecture
		"gallery_name" : module.SharedImageGallery.AgentSharedImage.gallery_name
		"hyper_v_generation" : module.SharedImageGallery.AgentSharedImage.hyper_v_generation
		"location" : module.SharedImageGallery.AgentSharedImage.location
		"name" : module.SharedImageGallery.AgentSharedImage.name
		"os_type" : module.SharedImageGallery.AgentSharedImage.os_type
		"resource_group_name" : module.SharedImageGallery.AgentSharedImage.resource_group_name
		"identifier" : module.SharedImageGallery.AgentSharedImage.identifier
    }
}

output "AppSharedImage" {
	value = {
		"accelerated_network_support_enabled" : module.SharedImageGallery.AppSharedImage.accelerated_network_support_enabled
		"architecture" : module.SharedImageGallery.AppSharedImage.architecture
		"gallery_name" : module.SharedImageGallery.AppSharedImage.gallery_name
		"hyper_v_generation" : module.SharedImageGallery.AppSharedImage.hyper_v_generation
		"location" : module.SharedImageGallery.AppSharedImage.location
		"name" : module.SharedImageGallery.AppSharedImage.name
		"os_type" : module.SharedImageGallery.AppSharedImage.os_type
		"resource_group_name" : module.SharedImageGallery.AppSharedImage.resource_group_name
		"identifier" : module.SharedImageGallery.AppSharedImage.identifier
    }
}

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