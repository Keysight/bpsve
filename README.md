
# BreakingPoint VE Deployment Templates

Welcome to the official GitHub repository for **Keysight BreakingPoint VE Deployment Templates**.  
This repository provides deployment configurations and templates for **BreakingPoint VE**, compatible with multiple cloud environments.

---

## 🖥️ Platforms

- [Amazon Web Services (AWS)](#amazon-web-services-aws)
- [Google Cloud Platform (GCP)](#google-cloud-platform-gcp)
- [Alibaba Cloud](#alibaba-cloud)
- [OpenStack](#openstack)

---

## <img src="https://a0.awsstatic.com/libra-css/images/logos/aws_logo_smile_1200x630.png" alt="AWS Logo" width="50"/> Amazon Web Services (AWS)

### 🔧 Configurations

This section includes `.bpt` configuration files tailored for specific AWS instance types:

- `c5.xlarge`
- `c5n.xlarge`

### 🚀 Deployment

Starting with version **11.00**, BreakingPoint VE Virtual Controller and Virtual Blade are available on the AWS Marketplace:

- [Virtual Controller](https://aws.amazon.com/marketplace/pp/prodview-4s5ym3tp4h3no)
- [Virtual Blade](https://aws.amazon.com/marketplace/pp/prodview-jlz7x47qr4m4c)

The BreakingPoint VE product is split between the two above VMs. Please make sure that you subscript to both of them before moving forward. 

---
#### 🔧 Prerequisites

Before you begin, ensure you have the following:
- **AWS Account**: An active AWS account with appropriate permissions.
- **BreakingPoint VE License**: Ensure you have a valid license for BreakingPoint VE.
---

### 📦 CloudFormation Templates

Located in `aws/Deployment/CloudFormation`, these JSON templates are organized into:

- **BPS Folder**: Includes both Virtual Controller and Blade(s)
  - **Demo Use Case**: Full deployment including networking, security groups, etc.
  - **Standalone Use Case**: Similar to Demo, but allows parameter customization (e.g., VPC CIDR)
  - **Add-On Use Case**: Designed to integrate with existing infrastructure
- **NP Folder**: Templates for deploying additional Virtual Blades
---

#### 🧪 Example #1: Deploying a Demo Use Case Template

To deploy a full BreakingPoint VE environment using a CloudFormation template:

```bash
aws cloudformation create-stack \
  --stack-name BPS-Demo-Deployment \
  --template-body file://Deployment/CloudFormation/BPS-VE-FullDeployment/AWS-1-Virtual-Blade-Demo-Use-Case.json
```
---

#### 🧷 Example #2: Deploying an Add-On Use Case Template

This adds a Virtual Blade to an existing infrastructure (e.g., VPC, subnets).

```bash
aws cloudformation create-stack \
  --stack-name BPS-AddOn-Deployment \
  --template-body file://Deployment/CloudFormation/BPS-VE-FullDeployment/AWS-1-Virtual-Blade-Add-On-Use-Case.json
```

### 📋 Notes
- Ensure the AWS CLI is configured with appropriate credentials and region.
- Replace file paths and parameter files with your actual paths if different.

---

### <img src="https://www.vectorlogo.zone/logos/terraformio/terraformio-icon.svg" width="30" alt="Terraform logo"> Terraform Templates

Welcome to the guide for deploying **BreakingPoint VE** using Terraform templates on AWS. This document provides step-by-step instructions, example commands, and best practices for a successful deployment.

### 🔧 Prerequisites

Before you begin, ensure you have the following (additionally on top of top prerequisites):

- **Terraform**: Installed on your local machine. Install Terraform
---

### 🛠️ Setup

#### 1. 🔧 Clone the Repository

Clone the BreakingPoint VE Terraform templates repository to your local machine:

```bash
git clone https://github.com/Keysight/bpsve.git
cd aws/Deployment/Terraform/
```
#### 🔐 2. Configure AWS Credentials

```bash
aws configure
```

#### 🌍 3. Initialize Terraform
Run the following command to initialize the working directory:

```bash
terraform init
```

#### 🧱 4. Review the type of template you wish to use
Choose between:
- Demo Templates
- Add On Templates

#### 🚀 5. Apply the Deployment
```bash
terraform apply -auto-approve
```

#### 🧩 6. Optional Usage
```bash
terraform validate
terraform plan
terraform state list
terraform output
```

#### 🧹 7. Cleanup
To destroy the deployment and remove all resources:
```bash
terraform destroy -auto-approve
```

### 📋 Notes
- Ensure your IAM user has permissions to create EC2 instances, VPC resources, and IAM roles.
- Use Terraform workspaces if managing multiple environments (e.g., dev, staging, prod).
- Store your state file securely if using remote backends like S3 with DynamoDB for locking.

---

## <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Google_Cloud_logo.svg/1920px-Google_Cloud_logo.svg.png" alt="GCP Logo" width="150"/> Google Cloud Platform (GCP)

### 🔧 Configurations

This folder contains several BPS-VE .bpt configurations that can be used on their respective instance sizes. 
We have 4 different folders: 
- C2-STANDARD-4
- C2-STANDARD-8
- C2-STANDARD-16

### 🚀 Deployment

Starting with version **11.00**, BreakingPoint VE Virtual Controller and Virtual Blade are available on the GCP Marketplace

- [Keysight BreakingPoint Virtual Edition](https://console.cloud.google.com/marketplace/product/keysight-public/keysight-breakingpoint-virtual-edition)

This product contains both the Virtual Controller and Virtual Blade as part of the product subscription.
---

#### 🔧 Prerequisites

Before you begin, ensure you have the following:
- **GCP Account**: An active GCP account with appropriate permissions.
- **GCP CLI**: Installed and configured with your credentials. Install GCP CLI
- **BreakingPoint VE License**: Ensure you have a valid license for BreakingPoint VE.
between each other. 
---

### Deployment Manager

Located in `google-cloud-platform/Deployment/DeploymentManager`, these JSON templates are organized into:

  - **Demo Use Case**: Full deployment including networking, security groups, etc.
  - **Add-On Use Case**: Designed to integrate with existing infrastructure
---

Deployment of these templates can be done through the Google Cloud Platform Cloud Shell. 
Before starting the deployment please upload your .jinja and .jinja.schema files to your Cloud Shell machine.

The following command should be executed to run a deployment: 

  ```bash
  gcloud deployment-manager deployments create DEPLOYMENT-NAME --template -GCP-1-Virtual-Blade-Demo-Use-Case-DM-Template.jinja
  ```

The status of the deployment will be displayed when the deployment will finish. 

#### <img src="https://www.vectorlogo.zone/logos/terraformio/terraformio-icon.svg" width="30" alt="Terraform logo"> Terraform Templates

Welcome to the guide for deploying **BreakingPoint VE** using Terraform templates on GCP. This document provides step-by-step instructions, example commands, and best practices for a successful deployment.

### 🔧 Prerequisites

Before you begin, ensure you have the following (additionally on top of top prerequisites):

- [Terraform](https://www.terraform.io/downloads.html) (v1.0+)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) (gcloud CLI)
- [Git](https://git-scm.com/downloads)
- Text editor (VS Code recommended)
---

### 🛠️ Setup

#### 1. 🔧 Clone the Repository

Clone the BreakingPoint VE Terraform templates repository to your local machine:

```bash
git clone https://github.com/Keysight/bpsve.git
cd google-cloud-platform/Deployment/Terraform/
```
#### 🔐 2. Install Google Cloud SDK

```bash
# For Ubuntu/Debian
curl https://sdk.cloud.google.com | bash
exec -l $SHELL

# For macOS (using Homebrew)
brew install --cask google-cloud-sdk

# For Windows, download from: https://cloud.google.com/sdk/docs/install
```

#### 3. Authenticate with Google Cloud
```bash
# Login to your Google account
gcloud auth login

# Set up application default credentials for Terraform
gcloud auth application-default login

# Verify authentication
gcloud auth list
```

#### 4. Create and Configure GCP Project
```bash
# Create a new project (optional)
gcloud projects create my-terraform-project-$(date +%s) --name="Terraform Demo Project"

# Set the project ID (replace with your project ID)
export PROJECT_ID="your-project-id"
gcloud config set project $PROJECT_ID

# Enable required APIs
gcloud services enable compute.googleapis.com
gcloud services enable sqladmin.googleapis.com
gcloud services enable servicenetworking.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
```

#### 🌍 5. Initialize Terraform
Run the following command to initialize the working directory:

```bash
terraform init
```

#### 🧱 4. Review the type of template you wish to use
Choose between:
- Demo Templates
- Add On Templates

#### 🚀 5. Apply the Deployment
```bash
terraform apply -auto-approve
```

#### 🧩 6. Optional Usage
```bash
terraform validate
terraform plan
terraform state list
terraform output
```

#### 🧹 7. Cleanup
To destroy the deployment and remove all resources:
```bash
terraform destroy -auto-approve
```

### 📋 Notes
- Use Terraform workspaces if managing multiple environments (e.g., dev, staging, prod).

### Cloud Shell
Contains two bash scripts that can help you create or delete network peering between two VPCs. 
You will need to provide the following parameters:
- Region name
- Login ID Tag
- Project Tag
- Verbose Output

## <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/AlibabaCloudLogo.svg/1920px-AlibabaCloudLogo.svg.png" alt="Alibaba Logo" width="150"/> Alibaba Cloud

This repository contains a collection of YAML templates for deploying infrastructure and applications on Alibaba Cloud using  **Resource Orchestration Service (ROS)**.
---

### 📦 Contents
- `alibaba/` – Templates for Alibaba Cloud ROS (e.g., ECS, VPC, RDS)
---

### 🛠️ Prerequisites

- An active [Alibaba Cloud account](httpss to the [ROS Consoleor [ACK Console- Properly configured [Alibaba Cloud CLI](https://www.alibabaclInstructions
- Virtual Controller and Virtual Blade QCOW2 images uploaded into the Alibaba Cloud account

### Deploying ROS Templates

This template deploys one Virtual Controller with the following characteristics:
- 8 GB RAM
- 4 vCPUs
- 30 GB Disk
- One management interface 

```bash
aliyun ros CreateStack \
  --StackName my-stack \
  --TemplateBody file://ansible/Ixia_BreakingPoint_Virtual_Controller_Alibaba_ROS_Template.yaml
```

This template deploys one Virtual Blade with the following characteristics:
- 8 GB RAM
- 4 vCPUs
- 10 GB Disk
- One management interface (for test interfaces please use UI to attach more interfaces )

```bash
aliyun ros CreateStack \
  --StackName my-stack \
  --TemplateBody file://ansible/Ixia_BreakingPoint_Virtual_Blade_Alibaba_ROS_Template.yaml
```

## <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/OpenStack%C2%AE_Logo_2016.svg/1920px-OpenStack%C2%AE_Logo_2016.svg.png" alt="OpenStack Logo" width="80"/> OpenStack

### Introduction 
For OpenStack private cloud we provide Heat templates that can be used to deploy one BreakingPoint VE Virtual Controller and one BreakingPoint VE Virtual Blade. 

### 🔧 Prerequisites

Before getting started, make sure you have the following in place:

- **BreakingPoint VE License**: A valid license for BreakingPoint VE is required.
- **Image Uploads**: The BreakingPoint VE Virtual Controller and Virtual Blade `.qcow2` images must be extracted and uploaded to the OpenStack Glance image service.
- **Flavor Configuration**: Create the following flavors in OpenStack for the respective components:
  - **Virtual Controller**: 8 GB RAM, 4 vCPUs, 30 GB disk
  - **Virtual Blade**: 8 GB RAM, 4 vCPUs, 10 GB disk

---

## Specialized knowledge
Before you deploy these templates, we recommend that you become familiar with the following notions:
- [OpenStack Flavors] https://docs.openstack.org/nova/rocky/user/flavors.html
- [OpenStack Glance Image Service] https://docs.openstack.org/glance/latest/
- [OpenStack Nova Compute Service] https://docs.openstack.org/nova/latest/
- [OpenStack Heat Templates] https://docs.openstack.org/heat/latest/
**Note:** If you are new to OpenStack, see [Getting Started with OpenStack](https://www.openstack.org/software/start/).