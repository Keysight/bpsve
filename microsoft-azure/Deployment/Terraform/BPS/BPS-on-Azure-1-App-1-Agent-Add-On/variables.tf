variable "AgentVmSize" {
	default = "Standard_F8s_v2"
	description = "Category, series and instance specifications associated with the Agent VM"
	type = string
	validation {
		condition = contains([	"Standard_F4s_v2",	"Standard_F8s_v2",	"Standard_F16s_v2"
							], var.AgentVmSize)
		error_message = <<EOF
AgentVmSize must be one of the following sizes:
	Standard_F4s_v2, Standard_F8s_v2, Standard_F16s_v2
		EOF
	}
}

variable "AppVmSize" {
	default = "Standard_F4s_v2"
	description = "Category, series and instance specifications associated with the App VM"
	type = string
	validation {
		condition = contains([	"Standard_F4s_v2",	"Standard_F8s_v2"
							], var.AppVmSize)
		error_message = <<EOF
AppVmSize must be one of the following sizes:
	Standard_F4s_v2, Standard_F8s_v2
		EOF
	}
}

variable "ClientId" {
	description = "Id of an application created in Azure Active Directory"
	sensitive = true
	type = string
}

variable "ClientSecret" {
	description = "Authentication value of an application created in Azure Active Directory"
	sensitive = true
	type = string
}

variable "Private1SubnetName" {
	description = "Subnet name assciated with the first private subnet"
	type = string
}

variable "Private2SubnetName" {
	description = "Subnet name assciated with the second private subnet"
	type = string
}

variable "PublicSubnetName" {
	description = "Subnet name assciated with the public subnet"
	type = string
}

variable "ResourceGroupLocation" {
	default = "East US"
	description = "Location of container metadata and control plane operations"
	type = string
}

variable "ResourceGroupName" {
	description = "Id of container that holds related resources that you want to manage together"
	type = string
}

variable "SharedImageGalleryName" {
	description = "Id of gallery that contains the application software image used by the deployment"
	type = string
}

variable "SharedImageGalleryResourceGroupName" {
	description = "Id of container that contains the application software image gallery"
	type = string
}

variable "SkipProviderRegistration" {
	default = false
	description = "Indicates whether or not to ignore registration of Azure Resource Providers due to insuffiencient permissions"
	type = bool
}

variable "SubscriptionId" {
	description = "Id of subscription and underlying services used by the deployment"
	sensitive = true
	type = string
}

variable "TenantId" {
	description  = "Id of an Azure Active Directory instance where one subscription may have multiple tenants"
	sensitive = true
	type = string
}

variable "UserEmailTag" {
	description = "Email address tag of user creating the deployment"
	type = string
}

variable "UserLoginTag" {
	description = "Login ID tag of user creating the deployment"
	type = string
}

variable "UserProjectTag" {
	default = "cloud-ist"
	description = "Project tag of user creating the deployment"
	type = string
}

variable "VnetName" {
	description = "Vnet name assciated with the virtual network"
	type = string
}