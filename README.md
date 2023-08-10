# BreakingPoint VE
Welcome to the GitHub repository for Keysight BreakingPoint VE Deployment Templates.

A licensed BreakingPoint VE product from Keysight is compatible with multiple environments.

# Microsoft Azure
## Configurations

This folder contains several BPS-VE .bpt configurations that can be used on their respective instance sizes. 
We have 4 different folders: 
- Standard_F4s
- Standard_F8s
- Standard_F16s

## Deployment
### Azure CLI
Since BPS-VE is not posted in the Microsoft Azure Marketplace we rely on sharing the Virtual Controller and Virtual Blade with you using Public Blobs.
This folder contains a bash script that you should run from your own Linux box. 
Prerequisites include having an Azure subscription and a destination resource group (including a destination storage account name). 

The script needs to be executed as following:
  ```
  ./BreakingPoint_Prepare_VMImages_Azure_CLI_Script.bash <destination-resource-group-name> <destination-storage-account-name>
  ```

This will copy the blobs from our account to yours and it will create a Azure Image with the Virtual Controller and Virtual Blade that you may use in your further testing (and in the ARM templates). 

### AzureResourceManager
Contains two folders: 
- BPS
    - Contains ARM templates for deployment of the Virtual Controller and Virtual Blade together
    - The templates are sepparated between three types of use cases:
        - Add-on Use Case - a type of deployment that takes advantage of an existing environment (e.g. an existing VPC, subnets, firewalls etc)
        - Demo Use Case - a type of deployment that deploys a full environment (including VPC, subnets, firewalls etc)
        - Fortinet DUT - a custom template for deployment of a BPS-VE setup and a Fortinet Instance (an instance reference needs to be added for this template to work)
        - Microsoft ALB - a custom template for deployment of a BPS-VE setup and a Microsoft Instance (an instance reference needs to be added for this template to work)
        - 1 / 2 / 4 / 8 / 12 number of Virtual Blades inside the configuration
- NP
    - Contains ARM templates for deployment of the Virtual Blade only
    - The templates are sepparated between three types of use cases:
        - Add-on Use Case - a type of deployment that takes advantage of an existing environment (e.g. an existing VPC, subnets, firewalls etc)
        - Demo Use Case - a type of deployment that deploys a full environment (including VPC, subnets, firewalls etc)

Please open the Cloud Shell under your Azure subscription. 
The following command should be executed to run a deployment: 
  ```
  az deployment group create --name DEPLOYMENY-NAME --resource-group RESOURCE-GROUP-NAME --template-file BPS_on_Azure_1-vBlade_Add-On_Use_Case_ARM_Template.json --parameters PARAMETERS-FILE.json
  ```

# Google Cloud Platform
## Configurations 

This folder contains several BPS-VE .bpt configurations that can be used on their respective instance sizes. 
We have 4 different folders: 
- C2-STANDARD-4
- C2-STANDARD-8
- C2-STANDARD-16

## Deployment
### Deployment Manager
Contains jinja and jinja.schema files that can be used to start a deployment on your Google Cloud account. 
The templates are sepparated between three types of use cases:
- Add-on Use Case - a type of deployment that takes advantage of an existing environment (e.g. an existing VPC, subnets, firewalls etc)
- Demo Use Case - a type of deployment that deploys a full environment (including VPC, subnets, firewalls etc)
- Fortinet DUT - a custom template for deployment of a BPS-VE setup and a Fortinet Instance (an instance reference needs to be added for this template to work)

Deployment of these templates can be done through the Google Cloud Platform Cloud Shell. 
Before starting the deployment please upload your .jinja and .jinja.schema files to your Cloud Shell machine.

The following command should be executed to run a deployment: 

  ```
  gcloud deployment-manager deployments create DEPLOYMENT-NAME --template BPS-on-GCP-1-vBlade-Demo-Use-Case-DM-Template.jinja
  ```

The status of the deployment will be displayed when the deployment will finish. 

### Cloud Shell
Contains two bash scripts that can help you create or delete network peering between two VPCs. 
You will need to provide the following parameters:
- Region name
- Login ID Tag
- Project Tag
- Verbose Output

# OpenStack
## Introduction 
For OpenStack private cloud we provide Heat templates that can be used to deploy one BreakingPoint VE Virtual Controller and one BreakingPoint VE Virtual Blade. 

## Prerequisites

The prerequisites are:
- BreakingPoint VE Virtual Controller and BreakingPoint VE Virtual Blade qcow2 images extracted and uploaded into OpenStack Glance Server (images)
- OpenStack setup and account for running your tests
- Flavors created for the BreakingPoint VE Virtual Controller and BreakingPoint VE Virtual Blade.
  - BreakingPoint VE Virtual Controller: 8GB RAM, 4vCPUs and 20GB Disk
  - BreakingPoint VE Virtual Blade: 8GB RAM, 4 vCPUs and 3GB Disk
 
## Specialized knowledge
Before you deploy these templates, we recommend that you become familiar with the following notions:
- [OpenStack Flavors] https://docs.openstack.org/nova/rocky/user/flavors.html
- [OpenStack Glance Image Service] https://docs.openstack.org/glance/latest/
- [OpenStack Nova Compute Service] https://docs.openstack.org/nova/latest/
- [OpenStack Heat Templates] https://docs.openstack.org/heat/latest/
**Note:** If you are new to OpenStack, see [Getting Started with OpenStack](https://www.openstack.org/software/start/).


