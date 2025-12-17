data "cloudinit_config" "init_cli" {
	gzip = false
	base64_encode = false
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

data "google_compute_machine_types" "Agent" {
	filter = "name = ${local.AgentMachineType}"
	zone = data.google_client_config.current.zone
}

data "http" "ip" {
	url = "https://ifconfig.me/ip"
}