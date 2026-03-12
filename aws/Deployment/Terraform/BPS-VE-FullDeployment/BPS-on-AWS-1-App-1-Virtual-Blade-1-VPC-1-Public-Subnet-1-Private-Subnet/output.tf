output "Agent1" {
	value = {
		ami = {
			image_id = module.Agent1.Ami.image_id
			name = module.Agent1.Ami.name
			owner_id = module.Agent1.Ami.owner_id
		}
		availability_zone = module.Agent1.Instance.availability_zone
		eth0 = {
			eip = {
				public_dns = module.Agent1.Eth0ElasticIp.public_dns
				public_ip = module.Agent1.Eth0ElasticIp.public_ip
			}
		}
		id = module.Agent1.Instance.id
		instance_type = {
			current_generation = data.aws_ec2_instance_type.Agent.current_generation
			dedicated_hosts_supported = data.aws_ec2_instance_type.Agent.dedicated_hosts_supported
			default_cores = data.aws_ec2_instance_type.Agent.default_cores
			default_network_card_index = data.aws_ec2_instance_type.Agent.default_network_card_index
			default_threads_per_core = data.aws_ec2_instance_type.Agent.default_threads_per_core
			default_vcpus = data.aws_ec2_instance_type.Agent.default_vcpus
			ena_srd_supported = data.aws_ec2_instance_type.Agent.ena_srd_supported
			ena_support = data.aws_ec2_instance_type.Agent.ena_support
			hypervisor = data.aws_ec2_instance_type.Agent.hypervisor
			ipv6_supported = data.aws_ec2_instance_type.Agent.ipv6_supported
			maximum_ipv4_addresses_per_interface = data.aws_ec2_instance_type.Agent.maximum_ipv4_addresses_per_interface
			maximum_ipv6_addresses_per_interface = data.aws_ec2_instance_type.Agent.maximum_ipv6_addresses_per_interface
			maximum_network_cards = data.aws_ec2_instance_type.Agent.maximum_network_cards
			maximum_network_interfaces = data.aws_ec2_instance_type.Agent.maximum_network_interfaces
			memory_size = data.aws_ec2_instance_type.Agent.memory_size
			name = module.Agent1.Instance.instance_type
			network_performance = data.aws_ec2_instance_type.Agent.network_performance
			supported_architectures = data.aws_ec2_instance_type.Agent.supported_architectures
			supported_cpu_features = data.aws_ec2_instance_type.Agent.supported_cpu_features
			supported_placement_strategies = data.aws_ec2_instance_type.Agent.supported_placement_strategies
		}
		private_dns = module.Agent1.Instance.private_dns
		private_ip = module.Agent1.Instance.private_ip
	}
}

output "App" {
	value = {
		ami = {
			image_id = module.App.Ami.image_id
			name = module.App.Ami.name
			owner_id = module.App.Ami.owner_id
		}
		availability_zone = module.App.Instance.availability_zone
		eth0 = {
			eip = {
				public_dns = module.App.Eth0ElasticIp.public_dns
				public_ip = module.App.Eth0ElasticIp.public_ip
			}
		}
		id = module.App.Instance.id
		instance_type = {
			current_generation = data.aws_ec2_instance_type.App.current_generation
			dedicated_hosts_supported = data.aws_ec2_instance_type.App.dedicated_hosts_supported
			default_cores = data.aws_ec2_instance_type.App.default_cores
			default_network_card_index = data.aws_ec2_instance_type.App.default_network_card_index
			default_threads_per_core = data.aws_ec2_instance_type.App.default_threads_per_core
			default_vcpus = data.aws_ec2_instance_type.App.default_vcpus
			ena_srd_supported = data.aws_ec2_instance_type.App.ena_srd_supported
			ena_support = data.aws_ec2_instance_type.App.ena_support
			hypervisor = data.aws_ec2_instance_type.App.hypervisor
			ipv6_supported = data.aws_ec2_instance_type.App.ipv6_supported
			maximum_ipv4_addresses_per_interface = data.aws_ec2_instance_type.App.maximum_ipv4_addresses_per_interface
			maximum_ipv6_addresses_per_interface = data.aws_ec2_instance_type.App.maximum_ipv6_addresses_per_interface
			maximum_network_cards = data.aws_ec2_instance_type.App.maximum_network_cards
			maximum_network_interfaces = data.aws_ec2_instance_type.App.maximum_network_interfaces
			memory_size = data.aws_ec2_instance_type.App.memory_size
			name = module.App.Instance.instance_type
			network_performance = data.aws_ec2_instance_type.App.network_performance
			supported_architectures = data.aws_ec2_instance_type.App.supported_architectures
			supported_cpu_features = data.aws_ec2_instance_type.App.supported_cpu_features
			supported_placement_strategies = data.aws_ec2_instance_type.App.supported_placement_strategies
		}
		private_dns = module.App.Instance.private_dns
		private_ip = module.App.Instance.private_ip
	}
}

output "AvailabilityZones" {
	value = {
		available = {
			names = data.aws_availability_zones.available.names
		}
		region = data.aws_availability_zones.available.region
	}
}

output "SshKey" {
	sensitive = true
	value = {
		private_key_pem = tls_private_key.SshKey.private_key_pem
	}
}
