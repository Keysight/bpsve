# AWS CloudFormation Deployment Templates

These template examples serve as starting points for deploying resources using AWS CloudFormation.

---

## ✅ Pre-Deployment Checklist

Before deploying, please ensure the following:

- **Understand CloudFormation Templates (CFT):**  
  Familiarize yourself with AWS CloudFormation and how it works. Refer to the AWS CloudFormation Documentation for guidance.

- **Configure SSH Keys:**  
  Set up your private and public SSH keys in the templates as described in this [guide](https://github.com/Keysight/bpsve/tree/main/aws/Deployment/CloudFormation#-case-study-why-do-we-need-ssh-public-and-private-keys-in-the-breakingpoint-ve-vms-)

## 🔧 Post-Deployment Steps

After deployment, complete the following steps:

1. **Activate the BPS-VE License**  
   Either activate a new license or configure the Virtual Controller to use an existing external license server (if applicable).

2. **Access the Virtual Controller**  
   - Open your browser and navigate to: `https://<VIRTUAL_CONTROLLER_IP>`  
   - Wait 5–10 minutes for all services to initialize.  
   - Log in using the default credentials:  
     **Username:** `admin`  
     **Password:** `admin`

3. **Attach the Virtual Blade**  
   - Go to the **Administration** page  
   - Navigate to **Manage Chassis**  
   - Attach the Virtual Blade to the Virtual Controller


---

## 📘 Template Guide

Below is a guide for the available CloudFormation templates:

### 1. `Update NP-on-AWS-1-Virtual-Blade-Add-On-Use-Case.json`  
**Location:**  
`aws/Deployment/CloudFormation/NP/`

This templates deploys the BPS-VE Virtual Blade **without** the Virtual Controller. This template can be used in case you need an extra Virtual Blade for your testing setup. This template **does not** attach the Virtual Blade to your Virtual Controller - you will need to do this step manually.

- **1x Virtual Blade**
- **All required AWS infrastructure components**, including:
  - Placement Group
  - Network Interfaces (Management and Test)

### 🔧 Template Parameters


This template requires the following input parameters:

- `UserEmailTag` – Email address tag of the user creating the stack  
  *(Minimum length: 14 characters)*

- `UserLoginTag` – Login ID tag of the user creating the stack  
  *(Minimum length: 4 characters)*

- `VpcId` – ID of the existing Virtual Private Cloud (VPC)

- `CtrlSubnetId` – Subnet ID for the Control network

- `CtrlSecurityGroupId` – Security Group ID for the Control subnet

- `Test1SubnetId` – Subnet ID for the first Test network
- `Test1SecurityGroupId` – Security Group ID for the first Test subnet

- `Test2SubnetId` – Subnet ID for the second Test network

- `Test2SecurityGroupId` – Security Group ID for the second Test subnet

- `BPSvBladeInstanceType` – Instance type for the BPS Virtual Blade VM  
  *(Options: `c6in.4xlarge`, `c5n.4xlarge`, `c5.4xlarge`; Default: `c5.4xlarge`)*

- `BPSvBlade1Eth0PrivateIpAddress` – Private IP address for Virtual Blade 1 Eth0 (Control subnet)  
  *(Must be a valid IPv4 address, e.g., `10.0.1.13`)*

- `BPSvBlade1Eth1PrivateIpAddresses` – Comma-separated list of private IP addresses for Virtual Blade 1 Eth1 (Test1 subnet)  
  *(Example: `10.0.2.22,10.0.2.23,...`)*

- `BPSvBlade1Eth2PrivateIpAddresses` – Comma-separated list of private IP addresses for Virtual Blade 1 Eth2 (Test2 subnet)  
  *(Example: `10.0.3.22,10.0.3.23,...`)*

- `SSHKey` – SSH Key to be assigned to your instance

- `InboundIPv4CidrBlock` – IPv4 CIDR block or IP address (e.g., `x.x.x.x/x`) to allow inbound access from your client  
  *(Must be a valid CIDR range, e.g., `203.0.113.0/24`)*

---