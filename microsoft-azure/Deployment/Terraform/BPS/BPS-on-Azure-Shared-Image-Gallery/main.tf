module "SharedImageGallery" {
	source = "armdupre/module-bps-shared-image-gallery/azurerm"
	version = "10.0.1"
	ResourceGroupLocation = azurerm_resource_group.ResourceGroup.location
	ResourceGroupName = azurerm_resource_group.ResourceGroup.name
	StorageAccountName = local.StorageAccountName
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
}

resource "azurerm_resource_group" "ResourceGroup" {
	name = local.ResourceGroupName
	location = local.ResourceGroupLocation
}