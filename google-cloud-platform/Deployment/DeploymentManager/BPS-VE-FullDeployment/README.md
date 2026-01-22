## GCP Deployment Manager Templates for Keysight BPS-VE Use Cases

This directory contains Jinja-based templates and schema files for Google Cloud Deployment Manager. These templates automate the provisioning of Keysight BreakingPoint Virtual Edition (BPS-VE) environments on GCP, supporting both Demo and Add-On use cases.

---

### 🚀 Deployment

Starting with version **11.00**, BreakingPoint VE Virtual Controller and Virtual Blade are available on the Google Cloud Marketplace as one product:

- [BreakingPoint Virtual Edition Google Cloud Marketplace](https://console.cloud.google.com/marketplace/product/keysight-public/keysight-breakingpoint-virtual-edition)

This marketplace product includes both Virtual Controller and Virtual Blade. 

---
### 🔧 Prerequisites

Before you begin, ensure you have the following:
- **GCP Account**: An active GCP account with appropriate permissions.
- **BreakingPoint VE License**: Ensure you have a valid license for BreakingPoint Virtual Edition.
---

### 📁 Templates Overview

#### 1. `-GCP-1-Virtual-Blade-Demo-Use-Case-DM-Template.jinja`

**Purpose:**  
Deploys a standalone BreakingPoint Virtual Edition (BPS-VE) demo environment with a single Virtual Blade instance and a single Virtual Controller for testing and evaluation.

**Resources Created:**
- 1x  Virtual Blade
- 1x  Virtual Controller
- A VPC network 
- Subnet and firewall rules for SSH and test traffic
- External IP address

**Parameters (via schema):**
- `project_id`: GCP project where resources will be deployed
- `region`: GCP region for the deployment
- `zone`: GCP zone for the VM
- `vpc_name`: Name of the VPC network
- `subnet_name`: Name of the subnet
- `instance_name`: Name of the Virtual Blade VM
- `machine_type`: GCP machine type (e.g., `n1-standard-4`)
- `image_family`: Image family for the VM (e.g., custom BPS image)
- `image_project`: Project hosting the image
- `external_ip`: Boolean to assign an external IP
- `network_tags`: Optional tags for firewall rules


1. **Open Cloud Shell** in the Google Cloud Console.
2. **Upload your files** or create them using `nano` or `vim`.
3. **Run the deployment command**:

```bash
gcloud deployment-manager deployments create -GCP-1-Virtual-Blade-Demo-Use-Case-DM-Template --template -GCP-1-Virtual-Blade-Demo-Use-Case-DM-Template.jinja
```

---

#### 2. `-GCP-1-Virtual-Blade-Add-On-Use-Case-DM-Template.jinja`

**Purpose:**  
A type of deployment that takes advantage of an existing environment (e.g. an existing VPC, subnets, firewalls etc).

**Resources Created:**
- 1x  Virtual Blade
- 1x  Virtual Controller
- Firewall rules (if needed)
- Attaches to an existing VPC and subnet

**Parameters (via schema):**
- `project_id`: GCP project ID
- `zone`: Zone for the new Virtual Blade
- `instance_name`: Name of the new Virtual Blade instance
- `vpc_name`: Existing VPC network name
- `subnet_name`: Existing subnet name
- `machine_type`: Machine type for the VM
- `image_family`: Image family for the Virtual Blade
- `image_project`: Project hosting the image
- `external_ip`: Boolean to assign an external IP
- `network_tags`: Optional tags for firewall rules

1. **Open Cloud Shell** in the Google Cloud Console.
2. **Upload your files** or create them using `nano` or `vim`.
3. **Run the deployment command**:

```bash
gcloud deployment-manager deployments create -GCP-1-Virtual-Blade-Add-On-Use-Case-DM-Template --template -GCP-1-Virtual-Blade-Add-On-Use-Case-DM-Template.jinja
```

---

### 📌 Notes

- Schema files are used for parameter validation and should not be deployed directly.