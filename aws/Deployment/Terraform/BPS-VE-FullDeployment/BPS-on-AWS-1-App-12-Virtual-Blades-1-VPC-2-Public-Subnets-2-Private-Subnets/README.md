# BPS-on-AWS-1-App-12-Virtual-Blades-1-VPC-2-Public-Subnets-2-Private-Subnets

## Description
This deployment creates a topology with a single virtual private cloud having two public facing subnets and two private subnets.

## Optional Variables
```
terraform.aws.auto.tfvars
terraform.optional.auto.tfvars
```
You **MAY** uncomment one or more lines as needed in these files and replace values to match your particular environment.

## Required Usage
```
terraform init
terraform apply -auto-approve
terraform destroy -auto-approve
```

## Optional Usage
```
terraform validate
terraform plan
terraform state list
terraform output
terraform output SshKey | tail -n +3 | head -n-3 | sed "s/^[ \t]*//" > .sshkey.pem
```
