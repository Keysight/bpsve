data "aws_caller_identity" "current" {}

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
			File1Content : local.File1Content
			File1Name : local.File1Name
			File2Content : local.File2Content
			File2Name : local.File2Name
			UserName: local.AppUserName
		})
	}
}

data "http" "ip" {
	url = "https://ifconfig.me"
}