variable "AgentInstanceType" {
	default = "c5n.xlarge"
	description = "Instance type of Agent VM"
	type = string
	validation {
		condition = contains([ "c5n.xlarge", "c5n.2xlarge", "c5n.4xlarge", "c5n.9xlarge", "c5n.18xlarge",
							   "c6in.xlarge", "c6in.2xlarge", "c6in.4xlarge", "c6in.8xlarge", "c6in.12xlarge", "c6in.16xlarge", "c6in.24xlarge", "c6in.32xlarge" ], var.AgentInstanceType)
		error_message = <<EOF
AgentInstanceType must be one of the following types:
	c5n.xlarge, c5n.2xlarge, c5n.4xlarge, c5n.9xlarge, c5n.18xlarge,
	c6in.xlarge, c6in.2xlarge, c6in.4xlarge, c6in.8xlarge, c6in.12xlarge, c6in.16xlarge, c6in.24xlarge, c6in.32xlarge
		EOF
	}
}

variable "ApiMaxRetries" {
	default = 1
	type = number
}

variable "InboundIPv4CidrBlocks" {
	default = [ "0.0.0.0/0" ]
	description = "List of IP Addresses /32 or IP CIDR ranges connecting inbound to App"
	type = list(string)
}

variable "Private1SubnetAvailabilityZone" {
	default = "us-east-1a"
	type = string
}

variable "Private2SubnetAvailabilityZone" {
	default = "us-east-1a"
	type = string
}

variable "PublicSubnetAvailabilityZone" {
	default = "us-east-1a"
	type = string
}

variable "Region" {
	default = "us-east-1"
	type = string
}

variable "UserEmailTag" {
	default = null
	description = "Email address tag of user creating the deployment"
	type = string
	validation {
		condition = var.UserEmailTag == null ? true : length(var.UserEmailTag) >= 14
		error_message = "UserEmailTag minimum length must be >= 14."
	}
}

variable "UserLoginTag" {
	default = null
	description = "Login ID tag of user creating the deployment"
	type = string
	validation {
		condition = var.UserLoginTag == null ? true : length(var.UserLoginTag) >= 4
		error_message = "UserLoginTag minimum length must be >= 4."
	}
}

variable "UserProjectTag" {
	default = null
	description = "Project tag of user creating the deployment"
	type = string
}
