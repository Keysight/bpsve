data "cloudinit_config" "init_cli" {
	gzip = true
	base64_encode = true
	part {
		content_type = "text/cloud-config"
		content = templatefile("cloud-init.yml", {
			File1Content : local.File1Content
			File1Name : local.File1Name
			File2Content : local.File2Content
			File2Name : local.File2Name
			File3Content : local.File3Content
			File3Name : local.File3Name
			UserName: local.AppUserName
		})
	}
}

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

data "http" "ip" {
	url = "https://ifconfig.me/ip"
}