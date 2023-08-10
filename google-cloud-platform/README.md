# About CyPerf Deployment Manager Templates 

## Introduction 

Welcome to the GitHub repository for Keysight BreakingPoint VE deployment guide using GCP Deployment Manager via the Cloud Shell. 

To start using BreakingPoint VE's Python templates and yaml configuration, please refer the **README** files in each individual directory and decide on which template to start with from the below list.

## Prerequisites
The prerequisites are:
- GCP shared images. Exact image name will be published in Keysight download page.
- GCP service account with 'compute admin' and 'compute network admin' role.

### Specialized knowledge
Before you deploy this Python template, we recommend that you become familiar with the following GCP services.
- [GCP Projects](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
- [Cloud Deployment Manager](https://cloud.google.com/deployment-manager)
- [VPC network](https://cloud.google.com/vpc/docs/vpc)
- [Compute Engine](https://cloud.google.com/compute)
- [GCP Images](https://cloud.google.com/compute/docs/images)
- [service account](https://cloud.google.com/iam/docs/creating-managing-service-accounts)

**Note:** If you are new to GCP, see [Getting Started with GCP](https://cloud.google.com/gcp/getting-started).

## GCP images
Following BreakingPoint VE images are publicly available
- For BreakingPoint VE Virtual Controller, ixia-breakingpoint-virtual-controller-9-30-121-update2 (Family name)
- For BreakingPoint VE Virtual Blade, ixia-breakingpoint-virtual-blade-9-30-121-update2 (Family name)

## Supported instance types 
- For BreakingPoint VE Virtual Controller, supported Machine type c2-standard-8.
- For BreakingPoint VE Virtual Blade, supported instance type c2-standard-4, c2-standard-8 and c2-standard-16.

The following lists the contents of the Google Cloud Platform folder: 
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

## Troubleshooting and Known Issues 
The Virtual Controller and Virtual Blade images cannot be obtained through the Google Cloud Platform Console (UI). Having known the name of family names of the two images, you may use them in your automatic / manual deployments from CloudShell. 

### Known Limitations

### Troubleshooting
