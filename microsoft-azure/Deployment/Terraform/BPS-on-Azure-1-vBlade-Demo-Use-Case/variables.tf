terraform {
  experiments = [variable_validation]
}

variable "AzureSubscriptionId" {
	type = string
	default = "00000000-0000-0000-0000-00000000000"
}

variable "AzureResourceGroupName" {
	type = string
	default = "Ixia_VE_Azure_9.22"
}

variable "IxiaImagesResourceGroupName" {
	type = string
	default = "Ixia_VE_Azure_9.22"
}

variable "DiagnosticsStorageAccountName" {
	type = string
	default = "Ixia_VE_Diagnostics"
}

variable "MgmtSecurityRuleSourceIpPrefix" {
	type = string
	default = "42.42.42.42/32"
}

variable "BpsSystemControllerImageName" {
	type = string
	default = "Ixia_BreakingPoint_Virtual_Controller_9.22"
}

variable "BpsSystemControllerVmSize" {
	type = string
	default = "Standard_F4s"
	validation {
		condition = can(regex("Standard_F4s", var.BpsSystemControllerVmSize)) || can(regex("Standard_F4s_v2", var.BpsSystemControllerVmSize))
		error_message = "BpsSystemControllerVmSize must be one of (Standard_F4s | Standard_F4s_v2) sizes."
	}
}

variable "BpsVirtualBladeImageName" {
	type = string
	default = "Ixia_BreakingPoint_Virtual_Blade_9.22"
}

variable "BpsVirtualBladeVmSize" {
	type = string
	default = "Standard_F16s"
	validation {
		condition = can(regex("Standard_F16s", var.BpsVirtualBladeVmSize)) || can(regex("Standard_F8s", var.BpsVirtualBladeVmSize)) || can(regex("Standard_F4s", var.BpsVirtualBladeVmSize))
		error_message = "BpsVirtualBladeVmSize must be one of (Standard_F16s | Standard_F8s | Standard_F4s) sizes."
	}
}

variable "OptionalVMPrefix" {
	type = string
	default = "Ixia"
}

variable "UserEmailTag" {
	type = string
	default = "Optional-Email-Tag"
}

variable "UserProjectTag" {
	type = string
	default = "Optional-Project-Tag"
}

variable "UserOptionsTag" {
	type = string
	default = "MANUAL"
}
