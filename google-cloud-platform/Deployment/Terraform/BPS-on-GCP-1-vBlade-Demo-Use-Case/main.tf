provider "google" {
	project = var.GCP_PROJECT_NAME
	region = var.GCP_REGION_NAME
	zone = var.GCP_ZONE_NAME
}

locals {
	GCP_PROJECT_NAME = var.GCP_PROJECT_NAME
	GCP_REGION_NAME = var.GCP_REGION_NAME
	GCP_ZONE_NAME = var.GCP_ZONE_NAME
	GCP_OWNER_TAG = var.GCP_OWNER_TAG
	GCP_LOGIN_ID_TAG = var.GCP_LOGIN_ID_TAG
	GCP_PROJECT_TAG = var.GCP_PROJECT_TAG
	GCP_OPTIONS_TAG = "MANUAL"
	GCP_MGMT_VPC_NETWORK_NAME = "management-vpc-network"
	GCP_MGMT_SUBNET_NAME = "management-subnet"
	GCP_MGMT_SUBNET_IP_RANGE = "10.0.10.0/24"
	GCP_MGMT_FIREWALL_RULE_NAME = "management-firewall-rule"
	GCP_MGMT_FIREWALL_RULE_DIRECTION = "INGRESS"
	GCP_MGMT_FIREWALL_RULE_PRIORITY = "1000"
	GCP_MGMT_FIREWALL_RULE_PORTS = [
		"22",
		"80",
		"443"
	]
	GCP_MGMT_FIREWALL_RULE_NETWORK_TARGET_TAGS = [
		"bps-vcontroller",
		"bps-vblade"
	]
	GCP_MGMT_FIREWALL_RULE_SOURCE_IP_RANGES = var.GCP_MGMT_FIREWALL_RULE_SOURCE_IP_RANGES
	GCP_CONSOLE_FIREWALL_RULE_NAME = "gcp-console-firewall-rule"
	GCP_CONSOLE_FIREWALL_RULE_DIRECTION = "INGRESS"
	GCP_CONSOLE_FIREWALL_RULE_PRIORITY = "1001"
	GCP_CONSOLE_FIREWALL_RULE_PORTS = [
		"22"
	]
	GCP_CONSOLE_FIREWALL_RULE_NETWORK_TARGET_TAGS = [
		"bps-vcontroller",
		"bps-vblade"
	]
	GCP_CONSOLE_FIREWALL_RULE_SOURCE_IP_RANGES = [
		"35.190.247.0/24",
		"35.191.0.0/16",
		"64.233.160.0/19",
		"66.102.0.0/20",
		"66.249.80.0/20",
		"72.14.192.0/18",
		"74.125.0.0/16",
		"108.177.8.0/21",
		"108.177.96.0/19",
		"130.211.0.0/22",
		"172.217.0.0/19",
		"172.217.32.0/20",
		"172.217.128.0/19",
		"172.217.160.0/20",
		"172.217.192.0/19",
		"172.253.56.0/21",
		"172.253.112.0/20",
		"173.194.0.0/16",
		"209.85.128.0/17",
		"216.58.192.0/19",
		"216.239.32.0/19"
	]
	GCP_CONTROL_FIREWALL_RULE_NAME = "control-firewall-rule"
	GCP_CONTROL_FIREWALL_RULE_DIRECTION = "INGRESS"
	GCP_CONTROL_FIREWALL_RULE_PRIORITY = "1003"
	GCP_CONTROL_FIREWALL_RULE_PORTS = "all"
	GCP_CONTROL_FIREWALL_RULE_SOURCE_TAGS = [
		"bps-vcontroller",
		"bps-vblade"
	]
	GCP_CONTROL_FIREWALL_RULE_TARGET_TAGS = [
		"bps-vcontroller",
		"bps-vblade"
	]
	GCP_TEST1_VPC_NETWORK_NAME = "test-01-vpc-network"
	GCP_TEST1_SUBNET_NAME = "test-01-subnet"
	GCP_TEST1_SUBNET_IP_RANGE = "10.0.2.0/24"
	GCP_TEST1_FIREWALL_RULE_NAME = "test-01-firewall-rule"
	GCP_TEST1_FIREWALL_RULE_DIRECTION = "INGRESS"
	GCP_TEST1_FIREWALL_RULE_PRIORITY = "1000"
	GCP_TEST1_FIREWALL_RULE_PORTS = "all"
	GCP_TEST1_FIREWALL_RULE_SOURCE_IP_RANGES = [
		"10.0.2.0/24",
		"10.0.3.0/24"
	]
	GCP_TEST1_FIREWALL_RULE_SOURCE_TAGS = [
		"bps-vblade"
	]
	GCP_TEST1_FIREWALL_RULE_TARGET_TAGS = [
		"bps-vblade"
	]
	GCP_TEST1_VPC_NETWORK_PEER_NAME = "test-01-vpc-network-peer"
	GCP_TEST2_VPC_NETWORK_NAME = "test-02-vpc-network"
	GCP_TEST2_FIREWALL_RULE_NAME = "test-02-firewall-rule"
	GCP_TEST2_FIREWALL_RULE_DIRECTION = "INGRESS"
	GCP_TEST2_FIREWALL_RULE_PRIORITY = "1000"
	GCP_TEST2_FIREWALL_RULE_PORTS = "all"
	GCP_TEST2_FIREWALL_RULE_SOURCE_IP_RANGES = [
		"10.0.2.0/24",
		"10.0.3.0/24"
	]
	GCP_TEST2_FIREWALL_RULE_SOURCE_TAGS = [
		"bps-vblade"
	]
	GCP_TEST2_FIREWALL_RULE_TARGET_TAGS = [
		"bps-vblade"
	]
	GCP_TEST2_SUBNET_NAME = "test-02-subnet"
	GCP_TEST2_SUBNET_IP_RANGE = "10.0.3.0/24"
	GCP_TEST2_VPC_NETWORK_PEER_NAME = "test-02-vpc-network-peer"
	GCP_VCONTROLLER_INSTANCE_NAME = "bps-vcontroller-01"
	GCP_VCONTROLLER_SERIAL_PORT_ENABLE = "true"
	GCP_VCONTROLLER_CAN_IP_FORWARD = "false"
	GCP_VCONTROLLER_CUSTOM_IMAGE_PROJECT_NAME = "bpsve-gcp"
	GCP_VCONTROLLER_CUSTOM_IMAGE_FAMILY_NAME = "ixia-breakingpoint-virtual-controller-9-22-116"
	GCP_VCONTROLLER_MACHINE_TYPE = var.GCP_VCONTROLLER_MACHINE_TYPE
	GCP_VCONTROLLER_IFACE_ETH0_PUBLIC_IP_ADDRESS_NAME = "bps-vcontroller-01-eth0-ip-addr"
	GCP_VCONTROLLER_NETWORK_TARGET_TAGS = [
		"bps-vcontroller"
	]
	GCP_VBLADE_INSTANCE_NAME = "bps-vblade-01"
	GCP_VBLADE_SERIAL_PORT_ENABLE = "true"
	GCP_VBLADE_CAN_IP_FORWARD = "true"
	GCP_VBLADE_CUSTOM_IMAGE_PROJECT_NAME = "open-ixia"
	GCP_VBLADE_CUSTOM_IMAGE_FAMILY_NAME = "ixia-breakingpoint-virtual-blade-9-22-116"
	GCP_VBLADE_MACHINE_TYPE = var.GCP_VBLADE_MACHINE_TYPE
	GCP_VBLADE_IFACE_ETH0_PRIVATE_IP_ADDRESS = "10.0.10.11"
	GCP_VBLADE_IFACE_ETH0_PUBLIC_IP_ADDRESS_NAME = "bps-vblade-01-eth0-ip-addr"
	GCP_VBLADE_IFACE_ETH1_PRIVATE_IP_ADDRESS = "10.0.2.15"
	GCP_VBLADE_IFACE_ETH1_PRIVATE_IP_ALIASES = "/28"
	GCP_VBLADE_IFACE_ETH2_PRIVATE_IP_ADDRESS = "10.0.3.15"
	GCP_VBLADE_IFACE_ETH2_PRIVATE_IP_ALIASES = "/28"
	GCP_VBLADE_NETWORK_TARGET_TAGS = [
		"bps-vblade"
	]
}

resource "google_compute_network" "GCP_MGMT_VPC_NETWORK" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_MGMT_VPC_NETWORK_NAME}"
	auto_create_subnetworks = "false"
	routing_mode = "REGIONAL"
}

resource "google_compute_subnetwork" "GCP_MGMT_SUBNET" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_MGMT_SUBNET_NAME}"
	ip_cidr_range = local.GCP_MGMT_SUBNET_IP_RANGE
	network = google_compute_network.GCP_MGMT_VPC_NETWORK.self_link
	region = local.GCP_REGION_NAME
}

resource "google_compute_network" "GCP_TEST1_VPC_NETWORK" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_TEST1_VPC_NETWORK_NAME}"
	auto_create_subnetworks = "false"
	routing_mode = "REGIONAL"
}

resource "google_compute_subnetwork" "GCP_TEST1_SUBNET" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_TEST1_SUBNET_NAME}"
	ip_cidr_range = local.GCP_TEST1_SUBNET_IP_RANGE
	network = google_compute_network.GCP_TEST1_VPC_NETWORK.self_link
	region = local.GCP_REGION_NAME
}

resource "google_compute_network" "GCP_TEST2_VPC_NETWORK" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_TEST2_VPC_NETWORK_NAME}"
	auto_create_subnetworks = "false"
	routing_mode = "REGIONAL"
}

resource "google_compute_subnetwork" "GCP_TEST2_SUBNET" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_TEST2_SUBNET_NAME}"
	ip_cidr_range = local.GCP_TEST2_SUBNET_IP_RANGE
	network = google_compute_network.GCP_TEST2_VPC_NETWORK.self_link
	region = local.GCP_REGION_NAME
}

resource "google_compute_firewall" "GCP_MGMT_FIREWALL_RULE" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_MGMT_FIREWALL_RULE_NAME}"
	allow {
		protocol = "tcp"
		ports = local.GCP_MGMT_FIREWALL_RULE_PORTS
	}
	direction = local.GCP_MGMT_FIREWALL_RULE_DIRECTION
	disabled = "false"
	network = google_compute_network.GCP_MGMT_VPC_NETWORK.self_link
	priority = local.GCP_MGMT_FIREWALL_RULE_PRIORITY
	source_ranges = local.GCP_MGMT_FIREWALL_RULE_SOURCE_IP_RANGES
	target_tags = local.GCP_MGMT_FIREWALL_RULE_NETWORK_TARGET_TAGS
}

resource "google_compute_firewall" "GCP_CONSOLE_FIREWALL_RULE" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_CONSOLE_FIREWALL_RULE_NAME}"
	allow {
		protocol = "tcp"
		ports = local.GCP_CONSOLE_FIREWALL_RULE_PORTS
	}
	direction = local.GCP_CONSOLE_FIREWALL_RULE_DIRECTION
	disabled = "false"
	network = google_compute_network.GCP_MGMT_VPC_NETWORK.self_link
	priority = local.GCP_CONSOLE_FIREWALL_RULE_PRIORITY
	source_ranges = local.GCP_CONSOLE_FIREWALL_RULE_SOURCE_IP_RANGES
	target_tags = local.GCP_CONSOLE_FIREWALL_RULE_NETWORK_TARGET_TAGS
}

resource "google_compute_firewall" "GCP_CONTROL_FIREWALL_RULE" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_CONTROL_FIREWALL_RULE_NAME}"
	allow {
		protocol = local.GCP_CONTROL_FIREWALL_RULE_PORTS
	}
	direction = local.GCP_CONTROL_FIREWALL_RULE_DIRECTION
	disabled = "false"
	network = google_compute_network.GCP_MGMT_VPC_NETWORK.self_link
	priority = local.GCP_CONTROL_FIREWALL_RULE_PRIORITY
	source_tags = local.GCP_CONTROL_FIREWALL_RULE_SOURCE_TAGS
	target_tags = local.GCP_CONTROL_FIREWALL_RULE_TARGET_TAGS
}

resource "google_compute_firewall" "GCP_TEST1_FIREWALL_RULE" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_TEST1_FIREWALL_RULE_NAME}"
	allow {
		protocol = local.GCP_TEST1_FIREWALL_RULE_PORTS
	}
	direction = local.GCP_TEST1_FIREWALL_RULE_DIRECTION
	disabled = "false"
	network = google_compute_network.GCP_TEST1_VPC_NETWORK.self_link
	priority = local.GCP_TEST1_FIREWALL_RULE_PRIORITY
	source_ranges = local.GCP_TEST1_FIREWALL_RULE_SOURCE_IP_RANGES
	source_tags = local.GCP_TEST1_FIREWALL_RULE_SOURCE_TAGS
	target_tags = local.GCP_TEST1_FIREWALL_RULE_TARGET_TAGS
}

resource "google_compute_firewall" "GCP_TEST2_FIREWALL_RULE" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_TEST2_FIREWALL_RULE_NAME}"
	allow {
		protocol = local.GCP_TEST2_FIREWALL_RULE_PORTS
	}
	direction = local.GCP_TEST2_FIREWALL_RULE_DIRECTION
	disabled = "false"
	network = google_compute_network.GCP_TEST2_VPC_NETWORK.self_link
	priority = local.GCP_TEST2_FIREWALL_RULE_PRIORITY
	source_ranges = local.GCP_TEST2_FIREWALL_RULE_SOURCE_IP_RANGES
	source_tags = local.GCP_TEST2_FIREWALL_RULE_SOURCE_TAGS
	target_tags = local.GCP_TEST2_FIREWALL_RULE_TARGET_TAGS
}

resource "google_compute_network_peering" "GCP_TEST1_VPC_NETWORK_PEER" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_TEST1_VPC_NETWORK_PEER_NAME}"
	network = google_compute_network.GCP_TEST1_VPC_NETWORK.id
	peer_network = google_compute_network.GCP_TEST2_VPC_NETWORK.id
}

resource "google_compute_network_peering" "GCP_TEST2_VPC_NETWORK_PEER" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_TEST2_VPC_NETWORK_PEER_NAME}"
	network = google_compute_network.GCP_TEST2_VPC_NETWORK.id
	peer_network = google_compute_network.GCP_TEST1_VPC_NETWORK.id
}

resource "google_compute_address" "GCP_VCONTROLLER_IFACE_ETH0_PUBLIC_IP_ADDRESS" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_VCONTROLLER_IFACE_ETH0_PUBLIC_IP_ADDRESS_NAME}"
	region = local.GCP_REGION_NAME
	network_tier = "PREMIUM"
	address_type = "EXTERNAL"
}

resource "google_compute_instance" "GCP_VCONTROLLER_INSTANCE" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_VCONTROLLER_INSTANCE_NAME}"
	can_ip_forward = local.GCP_VCONTROLLER_CAN_IP_FORWARD
	zone = local.GCP_ZONE_NAME
	machine_type = "zones/${local.GCP_ZONE_NAME}/machineTypes/${local.GCP_VCONTROLLER_MACHINE_TYPE}"
	boot_disk {
		device_name = "persistent-disk-0"
		auto_delete = "true"
		initialize_params {
			image = "projects/${local.GCP_VCONTROLLER_CUSTOM_IMAGE_PROJECT_NAME}/global/images/family/${local.GCP_VCONTROLLER_CUSTOM_IMAGE_FAMILY_NAME}"
		}
	}
	network_interface {
		network = google_compute_network.GCP_MGMT_VPC_NETWORK.self_link
		subnetwork = google_compute_subnetwork.GCP_MGMT_SUBNET.self_link
		access_config {
			nat_ip = google_compute_address.GCP_VCONTROLLER_IFACE_ETH0_PUBLIC_IP_ADDRESS.address
			network_tier = "PREMIUM"
		}
	}
	metadata = {
		Owner = local.GCP_OWNER_TAG
		Project = local.GCP_PROJECT_TAG
		Options = local.GCP_OPTIONS_TAG
		serial-port-enable = local.GCP_VCONTROLLER_SERIAL_PORT_ENABLE
	}
	tags = local.GCP_VCONTROLLER_NETWORK_TARGET_TAGS
	labels = {
		owner = replace(replace(local.GCP_OWNER_TAG, ".", "-"), "@", "-")
		project = lower(local.GCP_PROJECT_TAG)
		options = lower(local.GCP_OPTIONS_TAG)
	}
}

resource "google_compute_address" "GCP_VBLADE_IFACE_ETH0_PUBLIC_IP_ADDRESS" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_VBLADE_IFACE_ETH0_PUBLIC_IP_ADDRESS_NAME}"
	region = local.GCP_REGION_NAME
	network_tier = "PREMIUM"
	address_type = "EXTERNAL"
}

resource "google_compute_instance" "GCP_VBLADE_INSTANCE" {
	name = "${local.GCP_LOGIN_ID_TAG}-${local.GCP_PROJECT_TAG}-${local.GCP_VBLADE_INSTANCE_NAME}"
	can_ip_forward = local.GCP_VBLADE_CAN_IP_FORWARD
	zone = local.GCP_ZONE_NAME
	machine_type = "zones/${local.GCP_ZONE_NAME}/machineTypes/${local.GCP_VBLADE_MACHINE_TYPE}"
	boot_disk {
		device_name = "persistent-disk-0"
		auto_delete = "true"
		initialize_params {
			image = "projects/${local.GCP_VBLADE_CUSTOM_IMAGE_PROJECT_NAME}/global/images/family/${local.GCP_VBLADE_CUSTOM_IMAGE_FAMILY_NAME}"
		}
	}
	network_interface {
		network = google_compute_network.GCP_MGMT_VPC_NETWORK.self_link
		network_ip = local.GCP_VBLADE_IFACE_ETH0_PRIVATE_IP_ADDRESS
		subnetwork = google_compute_subnetwork.GCP_MGMT_SUBNET.self_link
		access_config {
			nat_ip = google_compute_address.GCP_VBLADE_IFACE_ETH0_PUBLIC_IP_ADDRESS.address
			network_tier = "PREMIUM"
		}
	}
	network_interface {
		network = google_compute_network.GCP_TEST1_VPC_NETWORK.self_link
		network_ip = local.GCP_VBLADE_IFACE_ETH1_PRIVATE_IP_ADDRESS
		subnetwork = google_compute_subnetwork.GCP_TEST1_SUBNET.self_link
		access_config {
			network_tier = "PREMIUM"
		}
		alias_ip_range {
			ip_cidr_range = local.GCP_VBLADE_IFACE_ETH1_PRIVATE_IP_ALIASES
		}
	}
	network_interface {
		network = google_compute_network.GCP_TEST2_VPC_NETWORK.self_link
		network_ip = local.GCP_VBLADE_IFACE_ETH2_PRIVATE_IP_ADDRESS
		subnetwork = google_compute_subnetwork.GCP_TEST2_SUBNET.self_link
		access_config {
			network_tier = "PREMIUM"
		}
		alias_ip_range {
			ip_cidr_range = local.GCP_VBLADE_IFACE_ETH2_PRIVATE_IP_ALIASES
		}
	}
	metadata = {
		Owner = local.GCP_OWNER_TAG
		Project = local.GCP_PROJECT_TAG
		Options = local.GCP_OPTIONS_TAG
		serial-port-enable = local.GCP_VBLADE_SERIAL_PORT_ENABLE
	}
	tags = local.GCP_VBLADE_NETWORK_TARGET_TAGS
	labels = {
		owner = replace(replace(local.GCP_OWNER_TAG, ".", "-"), "@", "-")
		project = lower(local.GCP_PROJECT_TAG)
		options = lower(local.GCP_OPTIONS_TAG)
	}
}
