# BPS-on-Azure-1-Virtual-Blade-1-Vnet-1-Public-Subnet-1-Private-Subnet

## Description
This deployment creates a topology with a single virtual network having a single public facing subnet and a single private subnet.

## Optional Variables
```
terraform.azure.auto.tfvars
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
terraform output SshKey | tail -n +3 | head -n-3 | sed "s/^[ \t]*//" > SshKey.pem
```