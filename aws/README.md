## <img src="https://a0.awsstatic.com/libra-css/images/logos/aws_logo_smile_1200x630.png" alt="AWS Logo" width="50"/> Amazon Web Services (AWS)

### 🔧 Configurations

This section includes `.bpt` configuration files tailored for specific AWS instance types:

- `c5.xlarge`
- `c5n.xlarge`

### 🚀 Deployment

Starting with version **11.00**, BreakingPoint Virtual Edition Virtual Controller and Virtual Blade are available on the AWS Marketplace:

- [Virtual Controller](https://aws.amazon.com/marketplace/pp/prodview-4s5ym3tp4h3no)
- [Virtual Blade](https://aws.amazon.com/marketplace/pp/prodview-jlz7x47qr4m4c)

The BreakingPoint Virtual Edition product is split between the two above VMs. Please make sure that you subscribe to both of them before moving forward. 

---
#### 🔧 Prerequisites

Before you begin, ensure you have the following:
- **AWS Account**: An active AWS account with appropriate permissions.
- **BreakingPoint VE License**: Ensure you have a valid license for BreakingPoint Virtual Edition.
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

This adds a Virtual Blade and a Virtual Controller to an existing infrastructure (e.g., VPC, subnets).

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