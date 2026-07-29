data "azurerm_client_config" "current" { }

data "azurerm_subscription" "current" {}

data "azurerm_subscriptions" "available" {}

data "cloudinit_config" "init_cli" {
	gzip = false
	base64_encode = false
	part {
		content_type = "text/cloud-config"
		content = templatefile("cloud-init.yml", {
			Agent1Eth0PrivateIpAddress = local.Agents.Agent1.Eth0PrivateIpAddress
			Agent2Eth0PrivateIpAddress = local.Agents.Agent2.Eth0PrivateIpAddress
			Agent3Eth0PrivateIpAddress = local.Agents.Agent3.Eth0PrivateIpAddress
			Agent4Eth0PrivateIpAddress = local.Agents.Agent4.Eth0PrivateIpAddress
			Agent5Eth0PrivateIpAddress = local.Agents.Agent5.Eth0PrivateIpAddress
			Agent6Eth0PrivateIpAddress = local.Agents.Agent6.Eth0PrivateIpAddress
			Agent7Eth0PrivateIpAddress = local.Agents.Agent7.Eth0PrivateIpAddress
			Agent8Eth0PrivateIpAddress = local.Agents.Agent8.Eth0PrivateIpAddress
			Agent9Eth0PrivateIpAddress = local.Agents.Agent9.Eth0PrivateIpAddress
			Agent10Eth0PrivateIpAddress = local.Agents.Agent10.Eth0PrivateIpAddress
			Agent11Eth0PrivateIpAddress = local.Agents.Agent11.Eth0PrivateIpAddress
			Agent12Eth0PrivateIpAddress = local.Agents.Agent12.Eth0PrivateIpAddress
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

data "http" "ip" {
	url = "https://ifconfig.me/ip"
}
