data "google_client_config" "current" {}

data "google_compute_subnetwork" "Private1Subnet" {
	name = local.Private1SubnetName
}

data "google_compute_network" "Private1VpcNetwork" {
	name = local.Private1VpcNetworkName
}

data "google_compute_subnetwork" "Private2Subnet" {
	name = local.Private2SubnetName
}

data "google_compute_network" "Private2VpcNetwork" {
	name = local.Private2VpcNetworkName
}

data "google_compute_subnetwork" "PublicSubnet" {
	name = local.PublicSubnetName
}

data "google_compute_network" "PublicVpcNetwork" {
	name = local.PublicVpcNetworkName
}