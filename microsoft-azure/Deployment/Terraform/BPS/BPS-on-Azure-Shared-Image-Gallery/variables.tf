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

variable "ResourceGroupLocation" {
	default = "East US"
	description = "Location of container metadata and control plane operations"
	type = string
}

variable "ResourceGroupName" {
	description = "Id of container that holds related resources that you want to manage together"
	type = string
}

variable "SkipProviderRegistration" {
	default = false
	description = "Indicates whether or not to ignore registration of Azure Resource Providers due to insuffiencient permissions"
	type = bool
}

variable "StorageAccountName" {
	description = "Id of storage account that must be unique across Azure"
	type = string
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