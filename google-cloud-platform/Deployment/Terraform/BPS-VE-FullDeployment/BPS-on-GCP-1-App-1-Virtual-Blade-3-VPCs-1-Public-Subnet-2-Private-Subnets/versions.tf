terraform {
	required_version = ">= 1.5.7"
	required_providers {
		google = {
			source  = "hashicorp/google"
			version = ">= 7.18.0"
		}
	}
}
