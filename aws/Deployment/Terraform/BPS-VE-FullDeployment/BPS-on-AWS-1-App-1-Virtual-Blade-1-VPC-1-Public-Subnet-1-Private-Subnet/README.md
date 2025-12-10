# BPS-on-AWS-1-App-1-Agent-1-VPC-1-Public-Subnet-1-Private-Subnet

## Description
This deployment creates a topology with a single virtual private cloud having a single public facing subnet and a single private subnet.

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
```