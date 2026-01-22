# AWS CloudFormation Deployment Templates

These template examples serve as starting points for deploying resources using AWS CloudFormation.

---

## ✅ Pre-Deployment Checklist

Before deploying, please ensure the following:

- **Understand CloudFormation Templates (CFT):**  
  Familiarize yourself with AWS CloudFormation and how it works. Refer to the AWS CloudFormation Documentation for guidance.

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

### 1. `AWS-1-Virtual-Blade-Add-On-Use-Case.json`  
**Location:**  
`aws/Deployment/CloudFormation/BPS-VE-FullDeployment/`

This templates deploys the BPS-VE product but relies on existing infrastructure that the product should run on:

- **1x Virtual Controller**
- **1x Virtual Blade**
- **All required AWS infrastructure components**, including:
  - Placement Group
  - Security Groups (Management and Test) with associated rules
  - Network Interfaces (Management and Test)
  - Elastic IPs and their associations

### 🔧 Template Parameters

These templates require the following input parameters from the user:

- `UserEmailTag` – Email address tag of the user creating the stack  
  *(Minimum length: 14 characters)*

- `UserLoginTag` – Login ID tag of the user creating the stack  
  *(Minimum length: 4 characters)*

- `VpcId` – ID of the existing Virtual Private Cloud (VPC)

- `MgmtSubnetId` – Subnet ID for the Management network

- `CtrlSubnetId` – Subnet ID for the Control network

- `Test1SubnetId` – Subnet ID for the first Test network

- `Test2SubnetId` – Subnet ID for the second Test network

- `BPSSCInstanceType` – Instance type for the Virtual Controller VM  
  *(Options: `c6in.4xlarge`, `c5n.4xlarge`, `c5.4xlarge`; Default: `c5.4xlarge`)*

- `BPSSCCtrl0PrivateIpAddress` – Private IP address for the Virtual Controller on the Control subnet  
  *(Must be a valid IPv4 address, e.g., `10.0.1.12`)*

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

### 2. `AWS-1-Virtual-Blade-Demo-Use-Case.json`  
**Location:**  
`aws/Deployment/CloudFormation/BPS-VE-FullDeployment/`

This templates deploys complete infrastructure that needs to be used by the BPS-VE product and:

- **1x Virtual Controller**
- **1x Virtual Blade**
- **All required AWS infrastructure components**, including:
  - Placement Group
  - VPC (Virtual Private Cloud)
  - Flow Logs
  - Subnets (Management and Test)
  - Security Groups (Management and Test) with associated rules
  - Internet Gateway
  - Route Tables, Routes, and VPC Gateway Attachment
  - Network Interfaces (Management and Test)
  - Elastic IPs and their associations

### 🔧 Template Parameters

These templates require the following input parameters from the user:

- `UserEmailTag` – Tag to identify the user by email
- `UserLoginTag` – Tag to identify the user by login name
- `BPSSCInstanceType` – Instance type for the Virtual Controller  
  *(Options: `c5.4xlarge`, `c6in.4xlarge`, `c5n.4xlarge`; Default: `c5.4xlarge`)*
- `BPSvBladeInstanceType` – Instance type for the Virtual Blade  
  *(Options: `c5.4xlarge`, `c6in.4xlarge`, `c5n.4xlarge`; Default: `c5.4xlarge`)*
- `SSHKey` – SSH Key to be assigned to your instance
- `InboundIPv4CidrBlock` – IPv4 CIDR block to allow inbound traffic from your PC
---
### 3. `AWS-1-Virtual-Blade-Standalone-Use-Case.json`  
**Location:**  
`aws/Deployment/CloudFormation/BPS-VE-FullDeployment/`

This templates deploys complete infrastructure that needs to be used by the BPS-VE product and:

- **1x Virtual Controller**
- **1x Virtual Blade**
- **All required AWS infrastructure components**, including:
  - Placement Group
  - VPC (Virtual Private Cloud)
  - Flow Logs
  - Subnets (Management and Test)
  - Security Groups (Management and Test) with associated rules
  - Internet Gateway
  - Route Tables, Routes, and VPC Gateway Attachment
  - Network Interfaces (Management and Test)
  - Elastic IPs and their associations

### 🔧 Template Parameters

These templates require the following input parameters from the user:

- `UserEmailTag` – Tag to identify the user by email
- `UserLoginTag` – Tag to identify the user by login name
- `VpcCidrBlock` - Virtual Private Cloud IP CIDR range
- `MgmtSubnetCidrBlock` - Management Subnet IP CIDR range
- `CtrlSubnetCidrBlock` - Management Subnet IP CIDR range
- `Test1SubnetCidrBlock` - Test1 Subnet IP CIDR range
- `Test2SubnetCidrBlock` - Test2 Subnet IP CIDR range
- `BPSSCCtrl0PrivateIpAddress` - Virtual Controller Management Subnet IP Address
- `BPSvBlade1Eth0PrivateIpAddress` - Virtual Blade Management Subnet IP Address
- `BPSvBlade1Eth1PrivateIpAddresses` - Virtual Blade 1 Eth1 Test1 Subnet IP Address CSV list
- `BPSvBlade1Eth2PrivateIpAddresses` - Virtual Blade 1 Eth2 Test2 Subnet IP Address CSV list
- `BPSSCInstanceType` – Instance type for the Virtual Controller  
  *(Options: `c5.4xlarge`, `c6in.4xlarge`, `c5n.4xlarge`; Default: `c5.4xlarge`)*
- `BPSvBladeInstanceType` – Instance type for the Virtual Blade  
  *(Options: `c5.4xlarge`, `c6in.4xlarge`, `c5n.4xlarge`; Default: `c5.4xlarge`)*
- `SSHKey` – SSH Key to be assigned to your instance
- `InboundIPv4CidrBlock` – IPv4 CIDR block to allow inbound traffic from your PC

The main difference between this template and the "Demo" category one is that here you can manually modify the VPC parameters such as VPC, Subnets or Private IPs. 
---

### 4. `AWS-2-Arm-Demo-Use-Case.json`  
**Location:**  
`aws/Deployment/CloudFormation/BPS-VE-FullDeployment/`

This templates deploys complete infrastructure that needs to be used by the BPS-VE product and:

- **1x Virtual Controller**
- **2x Virtual Blade**
- **All required AWS infrastructure components**, including:
  - Placement Group
  - VPC (Virtual Private Cloud)
  - Flow Logs
  - Subnets (Management and Test)
  - Security Groups (Management and Test) with associated rules
  - Internet Gateway
  - Route Tables, Routes, and VPC Gateway Attachment
  - Network Interfaces (Management and Test)
  - Elastic IPs and their associations

### 🔧 Template Parameters

These templates require the following input parameters from the user:

- `UserEmailTag` – Tag to identify the user by email
- `UserLoginTag` – Tag to identify the user by login name
- `BPSSCInstanceType` – Instance type for the Virtual Controller  
  *(Options: `c5.4xlarge`, `c6in.4xlarge`, `c5n.4xlarge`; Default: `c5.4xlarge`)*
- `BPSvBladeInstanceType` – Instance type for the Virtual Blade  
  *(Options: `c5.4xlarge`, `c6in.4xlarge`, `c5n.4xlarge`; Default: `c5.4xlarge`)*
- `SSHKey` – SSH Key to be assigned to your instance
- `InboundIPv4CidrBlock` – IPv4 CIDR block to allow inbound traffic from your PC
---

### 5. `AWS-2-Virtual-Blade-Demo-Use-Case.json`  
**Location:**  
`aws/Deployment/CloudFormation/BPS-VE-FullDeployment/`

This templates deploys complete infrastructure that needs to be used by the BPS-VE product and:

- **1x Virtual Controller**
- **2x Virtual Blade**
- **All required AWS infrastructure components**, including:
  - Placement Group
  - VPC (Virtual Private Cloud)
  - Flow Logs
  - Subnets (Management and Test)
  - Security Groups (Management and Test) with associated rules
  - Internet Gateway
  - Route Tables, Routes, and VPC Gateway Attachment
  - Network Interfaces (Management and Test)
  - Elastic IPs and their associations

### 🔧 Template Parameters

These templates require the following input parameters from the user:

- `UserEmailTag` – Tag to identify the user by email
- `UserLoginTag` – Tag to identify the user by login name
- `BPSSCInstanceType` – Instance type for the Virtual Controller  
  *(Options: `c5.4xlarge`, `c6in.4xlarge`, `c5n.4xlarge`; Default: `c5.4xlarge`)*
- `BPSvBladeInstanceType` – Instance type for the Virtual Blade  
  *(Options: `c5.4xlarge`, `c6in.4xlarge`, `c5n.4xlarge`; Default: `c5.4xlarge`)*
- `SSHKey` – SSH Key to be assigned to your instance
- `InboundIPv4CidrBlock` – IPv4 CIDR block to allow inbound traffic from your PC
---

