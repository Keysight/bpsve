output "Agent1" {
	value = {
		"architecture" :  module.Agent1.Instance.architecture 
		"can_ip_forward" : module.Agent1.Instance.can_ip_forward
		"cpu_platform" : module.Agent1.Instance.cpu_platform
		"current_status" : module.Agent1.Instance.current_status
		"image_name" : module.Agent1.Image.name
		"image_project" : module.Agent1.Image.project
		"instance_id" : module.Agent1.Instance.instance_id
		"machine_description" : data.google_compute_machine_types.Agent.machine_types.0.description
		"machine_guest_cpus" : data.google_compute_machine_types.Agent.machine_types.0.guest_cpus
		"machine_is_shared_cpus" : data.google_compute_machine_types.Agent.machine_types.0.is_shared_cpus
		"machine_memory_mb" : data.google_compute_machine_types.Agent.machine_types.0.memory_mb
		"machine_type" : module.App.Instance.machine_type
		"machine_type" : module.Agent1.Instance.machine_type
		"name" : module.Agent1.Instance.name
		"network_ip" : module.Agent1.Instance.network_ip
		"project" : module.Agent1.Instance.project
		"public_address" : module.Agent1.Eth0PublicIpAddress.address
		"public_address_type" : module.Agent1.Eth0PublicIpAddress.address_type
		"serial-port-enable" :  module.Agent1.Instance.serial-port-enable
		"zone" : module.Agent1.Instance.zone
	}
}

output "App" {
	value = {
		"architecture" : module.App.Instance.architecture 
		"can_ip_forward" : module.App.Instance.can_ip_forward
		"cpu_platform" : module.App.Instance.cpu_platform
		"current_status" : module.App.Instance.current_status
		"image_name" : module.App.Image.name
		"image_project" : module.App.Image.project
		"instance_id" : module.App.Instance.instance_id
		"machine_description" : data.google_compute_machine_types.App.machine_types.0.description
		"machine_guest_cpus" : data.google_compute_machine_types.App.machine_types.0.guest_cpus
		"machine_is_shared_cpus" : data.google_compute_machine_types.App.machine_types.0.is_shared_cpus
		"machine_memory_mb" : data.google_compute_machine_types.App.machine_types.0.memory_mb
		"machine_type" : module.App.Instance.machine_type
		"name" : module.App.Instance.name
		"network_ip" : module.App.Instance.network_ip
		"project" : module.App.Instance.project
		"public_address" : module.App.Eth0PublicIpAddress.address
		"public_address_type" : module.App.Eth0PublicIpAddress.address_type
		"public_ip" : split("//", module.App.Eth0PublicIpAddress.address)[1]
		"serial-port-enable" : module.App.Instance.serial-port-enable
		"zone" : module.App.Instance.zone
	}
}

output "Private1VpcNetwork" {
	value = {
		"mtu" : module.Vpc.Private1VpcNetwork.mtu
		"name" : module.Vpc.Private1VpcNetwork.name
	}
}

output "Private2VpcNetwork" {
	value = {
		"mtu" : module.Vpc.Private2VpcNetwork.mtu
		"name" : module.Vpc.Private2VpcNetwork.name
	}
}

output "PublicVpcNetwork" {
	value = {
		"mtu" : module.Vpc.PublicVpcNetwork.mtu
		"name" : module.Vpc.PublicVpcNetwork.name
	}
}

output "SshKey" {
	sensitive = true
	value = {
		"private_key_pem" : tls_private_key.SshKey.private_key_pem
	}
}