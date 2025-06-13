# OpenStack Heat Templates for BPS VE Deployment

This repository contains OpenStack Heat Orchestration Templates (HOT) for deploying **BreakingPoint VE (BPS VE)** components in OpenStack environments. These templates support BPS VE version **9.00 or newer** and are designed to automate the provisioning of Virtual Controllers and Virtual Blades.

---

## 📦 Templates Overview

### 🔹 1. Virtual Controller Template

- **Template:** `Ixia_BreakingPoint_Virtual_Controller_Heat_Template.yaml`
- **Variables:** `Ixia_BreakingPoint_Virtual_Controller_Heat_Template_Variables.yaml`

**What it does:**
- Deploys a single Virtual Controller instance
- Attaches a volume for persistent storage
- Connects to a management network

---

### 🔹 2. Virtual Blade Template

- **Template:** `Ixia_BreakingPoint_Virtual_Blade_Heat_Template.yaml`
- **Variables:** `Ixia_BreakingPoint_Virtual_Blade_Heat_Template_Variables.yaml`

**What it does:**
- Deploys a single Virtual Blade instance
- Connects to both management and test networks
- Attaches a volume for persistent storage
---

## 📌 Prerequisites

Before deploying, ensure the following:

- Access to an OpenStack environment with Heat enabled
- BPS VE images uploaded to Glance (Virtual Controller and Virtual Blade)
- Pre-created:
  - Management and test networks and subnets
  - Security group with appropriate rules
  - SSH key pair
- Sufficient quota for instances, volumes, and ports

---

## 🧾 Template Parameters

Each template uses a corresponding variables file to define deployment-specific values.

### Common Parameters

| Parameter Name       | Description                                      |
|----------------------|--------------------------------------------------|
| `image`              | Glance image name for the instance               |
| `flavor`             | OpenStack flavor (e.g., 4–8 vCPU, 8 GB RAM)      |
| `key_name`           | SSH key pair name                                |
| `security_group`     | Security group name                              |
| `volume_size`        | Volume size in GB (minimum: 14 GB)               |
| `availability_zone`  | (Optional) Availability zone for the instance    |

### Controller-Specific Parameters

| Parameter Name       | Description                                      |
|----------------------|--------------------------------------------------|
| `management_network` | Network for management traffic                   |
| `management_subnet`  | Subnet for management traffic                    |

### Blade-Specific Parameters

| Parameter Name       | Description                                      |
|----------------------|--------------------------------------------------|
| `management_network` | Network for management traffic                   |
| `management_subnet`  | Subnet for management traffic                    |
| `test_network`       | Network for test traffic                         |
| `test_subnet`        | Subnet for test traffic                          |

---

## 🛠️ How to Deploy

### Option 1: OpenStack CLI

```bash
openstack stack create -t Ixia_BreakingPoint_Virtual_Controller_Heat_Template.yaml \
  --parameter-file Ixia_BreakingPoint_Virtual_Controller_Heat_Template_Variables.yaml \
  BPSVE-Virtual-Controller

openstack stack create -t Ixia_BreakingPoint_Virtual_Blade_Heat_Template.yaml \
  --parameter-file Ixia_BreakingPoint_Virtual_Blade_Heat_Template_Variables.yaml \
  BPSVE-Virtual-Blade
```

### Option 2: Horizon Dashboard

1. Go to **Project > Orchestration > Stacks**
2. Click **Launch Stack**
3. Upload the template and variables file
4. Provide a stack name and launch

---

## 📤 Outputs

Each stack will output:

- The **instance ID** of the deployed VM
- The **management IP address** (if floating IP is associated)

---

## 📝 Post-Deployment Notes

- Allow a few minutes for the instances to fully initialize.
- For Virtual Blades, ensure test interfaces are configured as needed.
- You can monitor and manage the instances via Horizon or CLI.

---

## 📬 Support

For issues related to these templates or BPS VE deployment on OpenStack, please contact your Keysight representative or refer to the official documentation.

