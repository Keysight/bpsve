resource "tls_private_key" "SshKey" {
	algorithm = local.SshKeyAlgorithm
	rsa_bits = local.SshKeyRsaBits
}