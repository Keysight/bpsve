# GCP Deployment Manager Templates for Keysight BPS Use Cases

This directory contains Jinja2-based templates and schema files for Google Cloud Deployment Manager. These templates automate the provisioning of Keysight BreakingPoint System (BPS) virtual environments on GCP, supporting both demo and add-on use cases with a single vBlade instance.

---

## 📁 Templates Overview

### 1. `BPS-on-GCP-1-vBlade-Demo-Use-Case-DM-Template.jinja`

**Purpose:**  
Deploys a standalone BreakingPoint System (BPS) demo environment with a single vBlade instance for testing and evaluation.

**Resources Created:**
- A Compute Engine VM instance for the vBlade
- A VPC network (if not already existing)
- Subnet and firewall rules for SSH and BPS traffic
- External IP address (if specified)

**Parameters (via schema):**
- `project_id`: GCP project where resources will be deployed
- `region`: GCP region for the deployment
- `zone`: GCP zone for the VM
- `vpc_name`: Name of the VPC network
- `subnet_name`: Name of the subnet
- `instance_name`: Name of the vBlade VM
- `machine_type`: GCP machine type (e.g., `n1-standard-4`)
- `image_family`: Image family for the VM (e.g., custom BPS image)
- `image_project`: Project hosting the image
- `external_ip`: Boolean to assign an external IP
- `network_tags`: Optional tags for firewall rules

---

### 2. `BPS-on-GCP-1-vBlade-Demo-Use-Case-DM-Template.jinja.schema`

**Purpose:**  
Defines the input parameters and validation rules for the demo use case template.

**Highlights:**
- Enforces required fields like `project_id`, `zone`, and `instance_name`
- Provides default values for optional parameters
- Ensures correct types and constraints (e.g., boolean for `external_ip`)

---

### 3. `BPS-on-GCP-1-vBlade-Add-On-Use-Case-DM-Template.jinja`

**Purpose:**  
Deploys an additional vBlade instance into an existing BPS environment. Ideal for scaling or extending a previously deployed demo or production setup.

**Resources Created:**
- A Compute Engine VM instance for the new vBlade
- Optional firewall rules (if needed)
- Attaches to an existing VPC and subnet

**Parameters (via schema):**
- `project_id`: GCP project ID
- `zone`: Zone for the new vBlade
- `instance_name`: Name of the new vBlade instance
- `vpc_name`: Existing VPC network name
- `subnet_name`: Existing subnet name
- `machine_type`: Machine type for the VM
- `image_family`: Image family for the vBlade
- `image_project`: Project hosting the image
- `external_ip`: Boolean to assign an external IP
- `network_tags`: Optional tags for firewall rules

---

### 4. `BPS-on-GCP-1-vBlade-Add-On-Use-Case-DM-Template.jinja.schema`

**Purpose:**  
Defines the input parameters and validation rules for the add-on use case template.

**Highlights:**
- Validates that the user provides existing network and subnet names
- Ensures compatibility with the existing BPS deployment
- Supports optional customization of VM specs and network settings

---

## ✅ Prerequisites

- Google Cloud SDK installed and authenticated
- Deployment Manager API enabled
- IAM permissions to create Compute Engine resources and manage networks
- Existing BPS environment (for add-on template)

---

## 🚀 Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/Keysight/bpsve.git
   cd bpsve/google-cloud-platform/Deployment/DeploymentManager
   ```

2. Create a YAML configuration file (e.g., `config.yaml`) with the required parameters.

3. Deploy using the Deployment Manager:
   ```bash
   gcloud deployment-manager deployments create <deployment-name> \
     --config config.yaml
   ```

---

## 📝 Example `config.yaml`

```yaml
imports:
  - path: BPS-on-GCP-1-vBlade-Demo-Use-Case-DM-Template.jinja

resources:
  - name: bps-demo-vblade
    type: BPS-on-GCP-1-vBlade-Demo-Use-Case-DM-Template.jinja
    properties:
      project_id: "your-gcp-project-id"
      region: "us-central1"
      zone: "us-central1-a"
      vpc_name: "bps-vpc"
      subnet_name: "bps-subnet"
      instance_name: "bps-vblade-demo"
      machine_type: "n1-standard-4"
      image_family: "custom-bps-image"
      image_project: "your-image-project"
      external_ip: true
      network_tags: ["bps"]
```

---

## 📌 Notes

- Schema files are used for parameter validation and should not be deployed directly.
- Ensure that the image family and project are accessible and contain the correct BPS image.
- For production use, consider adding startup scripts, service accounts, and monitoring configurations.

