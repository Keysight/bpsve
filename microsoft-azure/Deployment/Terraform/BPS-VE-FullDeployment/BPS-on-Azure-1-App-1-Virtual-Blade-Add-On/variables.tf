variable "AgentVmSize" {
	default = "Standard_E8_v5"
	description = "Category, series and instance specifications associated with the Agent VM"
	type = string
	validation {
		condition = contains([	"Standard_E8_v5",	"Standard_E16_v5"
							], var.AgentVmSize)
		error_message = <<EOF
AgentVmSize must be one of the following sizes:
	Standard_F4s_v2, Standard_E8_v5, Standard_E16_v5
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

variable "UserEmailTag" {
	default = null
	description = "Email address tag of user creating the deployment"
	type = string
}

variable "UserLoginTag" {
	default = null
	description = "Login ID tag of user creating the deployment"
	type = string
}

variable "UserProjectTag" {
	default = null
	description = "Project tag of user creating the deployment"
	type = string
}

variable "VnetName" {
	description = "Vnet name assciated with the virtual network"
	type = string
}