## <img src="https://a0.awsstatic.com/libra-css/images/logos/aws_logo_smile_1200x630.png" alt="AWS Logo" width="50"/> Amazon Web Services (AWS)

### 🚀 Deployment

Starting with version **26.0.0**, BreakingPoint VE Virtual Controller and Virtual Blade are available on the AWS Marketplace:

- [Virtual Controller](https://aws.amazon.com/marketplace/pp/prodview-4s5ym3tp4h3no)
- [Virtual Blade](https://aws.amazon.com/marketplace/pp/prodview-jlz7x47qr4m4c)

The BreakingPoint VE product is split between the two above VMs. Please make sure that you subscript to both of them before moving forward. 

---
#### 🔧 Prerequisites

Before you begin, ensure you have the following:
- **AWS Account**: An active AWS account with appropriate permissions.
- **BreakingPoint VE License**: Ensure you have a valid license for BreakingPoint VE.
---

---

### 📦 CloudFormation Templates

Located in `aws/Deployment/CloudFormation`, these JSON templates are organized into:

- **BPS Folder**: Includes both Virtual Controller and Blade(s)
  - **Demo Use Case**: Full deployment including networking, security groups, etc.
  - **Standalone Use Case**: Similar to Demo, but allows parameter customization (e.g., VPC CIDR)
  - **Add-On Use Case**: Designed to integrate with existing infrastructure
- **NP Folder**: Templates for deploying additional Virtual Blades
---

#### 🧷 Example #1: Deploying an Add-On Use Case Template

This adds a Virtual Blade to an existing infrastructure (e.g., VPC, subnets).

```bash
aws cloudformation create-stack \
  --stack-name BPS-AddOn-Deployment \
  --template-body file://Deployment/CloudFormation/BPS-VE-VirtualBladeOnly/Update-NP-on-AWS-1-Virtual-Blade-Add-On-Use-Case.json
```

### 📋 Notes
- Ensure the AWS CLI is configured with appropriate credentials and region.
- Replace file paths and parameter files with your actual paths if different.

---
