data "aws_caller_identity" "current" {}

data "aws_ec2_instance_type" "Agent" {
	instance_type = local.AgentInstanceType
}

data "aws_ec2_instance_type" "App" {
	instance_type = local.AppInstanceType
}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {
	state = "available"
}

data "aws_security_group" "PrivateSecurityGroup" {
	filter {
		name = "tag:Name"
		values = [ local.PrivateSecurityGroupName ]
    }
}

data "aws_subnet" "PrivateSubnet" {
	filter {
		name = "tag:Name"
		values = [ local.PrivateSubnetName ]
    }
}

data "aws_security_group" "PublicSecurityGroup" {
	filter {
		name = "tag:Name"
		values = [ local.PublicSecurityGroupName ]
    }
}

data "aws_subnet" "PublicSubnet" {
	filter {
		name = "tag:Name"
		values = [ local.PublicSubnetName ]
    }
}

data "cloudinit_config" "init_cli" {
	gzip = true
	base64_encode = true
	part {
		content_type = "text/cloud-config"
		content = templatefile("cloud-init.yml", {
			Agent1Eth0PrivateIpAddress = local.Agent1Eth0PrivateIpAddress
			AppAdminUserName = local.AppAdminUserName
			File1Content = local.File1Content
			File1Name = local.File1Name
			File2Content = local.File2Content
			File2Name = local.File2Name
			File3Content = local.File3Content
			File3Name = local.File3Name
			File4Content = local.File4Content
			File4Name = local.File4Name
			UserName = local.AppUserName
		})
	}
}
