# Alibaba Cloud ROS Templates for BPS VE Deployment

This repository contains two Alibaba Cloud Resource Orchestration Service (ROS) templates for deploying BreakingPoint VE (BPS VE) components in Alibaba Cloud environments. These templates are compatible with BPS VE version **9.00 or newer**.

---

## 📦 Templates Overview

### 1. **BPS VE Virtual Controller Template**

This template provisions a single ECS instance named `Virtual_Controller` to serve as the BPS VE Virtual Controller.

**Key Features:**
- Deploys 1 ECS instance
- Uses a specified image and instance type
- Requires pre-existing VPC, vSwitch, and Security Group

### 2. **BPS VE Virtual Blade Template**

This template provisions a single ECS instance named `Virtual_Blade` and creates a new vSwitch for test traffic. The instance is configured with one ENI for management. Test ENIs must be added manually after deployment.

**Key Features:**
- Deploys 1 ECS instance
- Creates a new vSwitch for test traffic
- Uses a specified image and instance type
- Requires pre-existing VPC, management vSwitch, and Security Group

---

## 📌 Prerequisites

Before deploying either template, ensure the following resources are already created in your Alibaba Cloud account:

- A **VPC** configured for management traffic
- A **vSwitch** for management (for both templates)
- A **Security Group** with appropriate access rules
- A valid **Image ID** for the BPS VE Virtual Controller or Blade (QCOW2 format)

---

## 🧾 Template Parameters

### 🔹 Common Parameters

| Parameter           | Description                                                                 | Example / Default           |
|---------------------|-----------------------------------------------------------------------------|-----------------------------|
| `InstanceName`      | Name of the ECS instance to be created                                      | `Virtual_Controller` / `Virtual_Blade` |
| `ImageId`           | Image ID of the BPS VE component                                            | `BPS VE Virtual Controller Image ID` |
| `InstanceType`      | ECS instance type                                                           | `ecs.sn1ne.2xlarge`         |
| `vpc`               | Name of the pre-configured VPC                                              | `Management_VPC`            |
| `SecurityGroupName` | Name of the pre-configured Security Group                                   | `BPS VE Security Group`     |

### 🔹 Controller-Specific Parameters

| Parameter   | Description                      | Default Value         |
|-------------|----------------------------------|------------------------|
| `vswitch`   | Name of the vSwitch for management | `Management_vSwitch` |

### 🔹 Blade-Specific Parameters

| Parameter         | Description                                      | Default Value         |
|-------------------|--------------------------------------------------|------------------------|
| `ManagementvSwitch` | Name of the vSwitch for management              | `Management_vSwitch`   |
| `TestvSwitch`       | Name of the vSwitch to be created for test traffic | `Test_vSwitch`       |

---

## 🚀 How to Deploy

You can deploy these templates using the Alibaba Cloud Console or the ROS CLI.

### Option 1: Alibaba Cloud Console

1. Log in to the [Alibaba Cloud ROS Console](https://**Create Stack**.
3. Upload the desired template or paste its contents.
4. Fill in the required parameters.
5. Launch the stack.

### Option 2: ROS CLI

```bash
aliyun ros CreateStack \
  --TemplateBody file://bps-ve-template.json \
  --StackName BPSVEStack \
  --Parameters \
    '[{"ParameterKey":"InstanceName","ParameterValue":"Virtual_Controller"}, ...]'
