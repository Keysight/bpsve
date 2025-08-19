provider "aws" {
	access_key = local.AwsAccessCredentialsAccessKey
	secret_key = local.AwsAccessCredentialsSecretKey
	region = var.Region
	max_retries = local.ApiMaxRetries
}