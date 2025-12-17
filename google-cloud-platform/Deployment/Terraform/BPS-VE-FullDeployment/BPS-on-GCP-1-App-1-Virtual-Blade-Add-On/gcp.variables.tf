variable "Credentials" {
	default = null
	description = "Path to (or contents of) a service account key file in JSON format"
	sensitive = true
	type = string
}