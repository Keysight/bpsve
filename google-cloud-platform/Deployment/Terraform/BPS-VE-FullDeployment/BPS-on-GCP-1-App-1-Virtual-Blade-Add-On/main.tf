module "App" {
	source = "git::https://github.com/armdupre/terraform-google-module-bps-app.git?ref=11.20.4"
	Eth0SubnetName = data.google_compute_subnetwork.PublicSubnet.name
	Eth0VpcNetworkName = data.google_compute_network.PublicVpcNetwork.name
	MachineType = local.AppMachineType
	RegionName = data.google_client_config.current.region
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	ZoneName = data.google_client_config.current.zone
	init_cli = data.cloudinit_config.init_cli.rendered
}

module "Agent1" {
	source = "git::https://github.com/armdupre/terraform-google-module-bps-agent.git?ref=11.20.4"
	Eth0SubnetName = data.google_compute_subnetwork.PublicSubnet.name
	Eth0VpcNetworkName = data.google_compute_network.PublicVpcNetwork.name
	Eth1SubnetName = data.google_compute_subnetwork.Private1Subnet.name
	Eth1VpcNetworkName = data.google_compute_network.Private1VpcNetwork.name
	Eth2SubnetName = data.google_compute_subnetwork.Private2Subnet.name
	Eth2VpcNetworkName = data.google_compute_network.Private2VpcNetwork.name
	InstanceId = local.Agent1InstanceId
	MachineType = local.AgentMachineType
	RegionName = data.google_client_config.current.region
	UserEmailTag = local.UserEmailTag
	UserLoginTag = local.UserLoginTag
	UserProjectTag = local.UserProjectTag
	ZoneName = data.google_client_config.current.zone
	init_cli = data.cloudinit_config.init_cli.rendered
}

resource "random_id" "RandomId" {
	byte_length = 4
}