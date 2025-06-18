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


## 🔒 Why do we need SSH Public and Private Keys in the BreakingPoint VE VMs ? 

The Virtual Controller acts as a Virtual Blade manager and needs to communicate with one or more Virtual Blades to be able to attach the Virtual Blades to the Virtual Controller and run your tests. 

Instead of using static SSH keys residing on the Virtual Controller and Virtual Blade, we rely on the end user to add those SSH keys at deployment time.

#### 🔑 How do we generate SSH Keys to use in Amazon AWS ? 

##### ❓ What are SSH Keys?

SSH keys are a pair of cryptographic keys used for secure authentication:
- **Private Key**: Kept secret on your local machine
- **Public Key**: Shared with servers you want to access
---
#### Linux Environment

###### Prerequisites
Most Linux distributions come with OpenSSH pre-installed. If not, install it:

```bash
# Ubuntu/Debian
sudo apt update && sudo apt install openssh-client

# CentOS/RHEL/Fedora
sudo yum install openssh-clients
# or for newer versions
sudo dnf install openssh-clients
```

###### Generating SSH Keys

###### Basic Key Generation
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

###### Step-by-step Process
1. **Run the command**:
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```

2. **Choose file location** (press Enter for default):
   ```
   Enter file in which to save the key (/home/username/.ssh/id_rsa):
   ```

3. **Set passphrase** (optional but recommended):
   ```
   Enter passphrase (empty for no passphrase):
   Enter same passphrase again:
   ```

###### Key Type Options
```bash
# RSA (most common, good compatibility)
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

###### Advanced Options
```bash
# Generate with custom filename
ssh-keygen -t rsa -b 4096 -f ~/.ssh/my_custom_key -C "your_email@example.com"

# Generate without passphrase (not recommended for production)
ssh-keygen -t rsa -b 4096 -N "" -C "your_email@example.com"
```

###### Viewing Generated Keys

```bash
# List keys in SSH directory
ls -la ~/.ssh/

# View public key content
cat ~/.ssh/id_rsa.pub

# View private key content (be careful!)
cat ~/.ssh/id_rsa
```

---
### Windows Environment

#### Install PuTTY
Download PuTTY from the official website: https://www.putty.org/

###### Generate Keys with PuTTYgen
1. **Launch PuTTYgen** (comes with PuTTY installation)
2. **Select key type**: RSA (recommended)
3. **Set key size**: 4096 bits
4. **Click "Generate"**
5. **Move mouse randomly** in the blank area to generate randomness
6. **Add comment** (optional): your email or identifier
7. **Set passphrase** (optional but recommended)
8. **Save private key**: Click "Save private key" (.ppk format)
9. **Copy public key**: Select and copy the text in the "Public key" box

##### Convert PuTTY Keys to OpenSSH Format
```powershell
# Convert .ppk to OpenSSH private key
puttygen keyfile.ppk -O private-openssh -o keyfile

# Convert .ppk to OpenSSH public key
puttygen keyfile.ppk -O public-openssh -o keyfile.pub
```
---
### AWS SSH Keys Retrieval Methods

#### EC2 Key Pairs Management

AWS EC2 Key Pairs store only the public key. The private key is provided only once during creation and cannot be retrieved later.

##### Creating Key Pairs via AWS Console
1. Navigate to **EC2 Dashboard** → **Key Pairs**
2. Click **Create Key Pair**
3. Choose format:
   - **.pem** (OpenSSH format)
   - **.ppk** (PuTTY format)
4. Download the private key immediately (only chance!)

##### Extracting Public and Private Keys from .pem Files

This guide shows how to extract public and private keys from .pem files using various methods and tools.

###### Understanding .pem Files
A .pem (Privacy-Enhanced Mail) file can contain:
- Private keys only
- Public keys only
- Both private and public keys
- Certificates
- Certificate chains

###### Extract SSH Public Key from Private Key

```bash
# Generate SSH public key from private key
ssh-keygen -y -f private_key.pem > public_key.pub

# With comment
ssh-keygen -y -f private_key.pem -C "user@example.com" > public_key.pub
```

###### Convert Between Formats

```bash
# Convert OpenSSH to PEM format
ssh-keygen -p -m PEM -f private_key.pem

# Convert PEM to OpenSSH format
ssh-keygen -p -m OpenSSH -f private_key.pem
```

---

## 🔐 Applying SSH Keys to AWS CloudFormation Templates

To enable secure access, you must configure your previously generated SSH key pair in the `UserData` section of each instance (Virtual Controller and Virtual Blade):

- **Insert your SSH keys**: Replace the placeholder values (zeros) with your actual private and public SSH keys.
- **Maintain existing paths**: Do not modify the file paths specified in the template—these must remain unchanged.
- **Cloud-init integration**: The template uses `cloud-init` to inject the SSH keys into the virtual machines during initialization.
- **Important**: If the SSH keys are not correctly applied, the attach operation will fail.

``` json
				"UserData": {
				  "Fn::Base64": {
					"Fn::Join": [
					  "",
					  [
						"#cloud-config\n",
						"write_files:\n",
						"  - path: /home/ixia/.ssh/id_rsa\n",
						"    permissions: '0400'\n", 
						"    owner: ixia:ixia\n",
						"    content: |\n",
						"      -----BEGIN OPENSSH PRIVATE KEY-----\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      0000000000000000000000000000000000000000000000000000000000000000000000\n",
						"      00000000000000000000000000000000000000000000\n",
						"      -----END OPENSSH PRIVATE KEY-----\n",
						"  - path: /home/ixia/.ssh/id_rsa.pub\n",
						"    permissions: '0600'\n",
						"    owner: ixia:ixia\n",
						"    content: |\n",
						"      ssh-rsa 00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 user@user\n",
						"  - path: /home/ixia/.ssh/authorized_keys\n",
						"    permissions: '0644'\n",
						"    owner: ixia:ixia\n",
						"    content: |\n",
						"      ssh-rsa 00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 user@user\n",
						"runcmd:\n",
						"  - [ \"chmod\", \"755\", \"/home/ixia/.ssh\" ]\n",
						"  - [ \"chown\", \"ixia:ixia\", \"/home/ixia/.ssh\" ]\n"
					  ]
					]
				  }
				}
```

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

