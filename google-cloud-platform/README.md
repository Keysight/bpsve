## <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Google_Cloud_logo.svg/1920px-Google_Cloud_logo.svg.png" alt="GCP Logo" width="150"/> Google Cloud Platform (GCP)

### 🔧 Configuration

This folder contains several BPS-VE .bpt configurations that can be used on their respective instance sizes. 
We have 4 different folders: 
- C2-STANDARD-4
- C2-STANDARD-8
- C2-STANDARD-16

### 🚀 Deployment

Starting with version **11.00**, BreakingPoint Virtual Edition Virtual Controller and Virtual Blade are available on the GCP Marketplace here:

- [Keysight BreakingPoint Virtual Edition Marketplace](https://console.cloud.google.com/marketplace/product/keysight-public/keysight-breakingpoint-virtual-edition)

This product contains both the Virtual Controller and Virtual Blade as part of the product subscription.
---

#### 🔧 Prerequisites

Before you begin, ensure you have the following:
- **GCP Account**: An active GCP account with appropriate permissions.
- **GCP CLI**: Installed and configured with your credentials. Install GCP CLI
- **BreakingPoint VE License**: Ensure you have a valid license for BreakingPoint Virtual Edition.
---

### 📦 Deployment Manager Templates

Located in `google-cloud-platform/Deployment/DeploymentManager`, these JINJA templates are organized into:

  - **Demo Use Case**: Full deployment including networking, security groups, etc.
  - **Add-On Use Case**: Designed to integrate with existing infrastructure
---

#### 🧪 Example #1: Deploying a Demo Use Case Template

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
gcloud deployment-manager deployments create GCP-1-Virtual-Blade-Demo-Use-Case --template GCP-1-Virtual-Blade-Demo-Use-Case.jinja
```
---

#### 🧷 Example #2: Deploying an Add-On Use Case Template

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
gcloud deployment-manager deployments create GCP-1-Virtual-Blade-Add-On-Use-Case --template GCP-1-Virtual-Blade-Add-On-Use-Case.jinja
```