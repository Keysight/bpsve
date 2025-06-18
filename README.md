
# BreakingPoint VE Deployment Templates

Welcome to the official GitHub repository for **Keysight BreakingPoint VE Deployment Templates**.  
This repository provides deployment configurations and templates for **BreakingPoint VE**, compatible with multiple cloud environments.

---

## 🖥️ Platforms

- [Amazon Web Services (AWS)](#amazon-web-services-aws)
- [Google Cloud Platform (GCP)](#google-cloud-platform-gcp)
- [Alibaba Cloud](#alibaba-cloud)
- [OpenStack](#openstack)

---

## <img src="https://a0.awsstatic.com/libra-css/images/logos/aws_logo_smile_1200x630.png" alt="AWS Logo" width="50"/> Amazon Web Services (AWS)

### 🔧 Configurations

This section includes `.bpt` configuration files tailored for specific AWS instance types:

- `c5.xlarge`
- `c5n.xlarge`

### 🚀 Deployment

Starting with version **11.00**, BreakingPoint VE Virtual Controller and Virtual Blade are available on the AWS Marketplace:

- [Virtual Controller](https://aws.amazon.com/marketplace/pp/prodview-4s5ym3tp4h3no)
- [Virtual Blade](https://aws.amazon.com/marketplace/pp/prodview-jlz7x47qr4m4c)

The BreakingPoint VE product is split between the two above VMs. Please make sure that you subscript to both of them before moving forward. 

---
#### 🔧 Prerequisites

Before you begin, ensure you have the following:
- **AWS Account**: An active AWS account with appropriate permissions.
- **BreakingPoint VE License**: Ensure you have a valid license for BreakingPoint VE.
- **SSH Public and Private Pregenerated Keys**: These SSH keys will be used by the Virtual Controller and Virtual Blade VMs to communicate between each other. 
---

#### 🔒 Case Study: Why do we need SSH Public and Private Keys in the BreakingPoint VE VMs ? 

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

### 📦 CloudFormation Templates

Located in `aws/Deployment/CloudFormation`, these JSON templates are organized into:

- **BPS Folder**: Includes both Virtual Controller and Blade(s)
  - **Demo Use Case**: Full deployment including networking, security groups, etc.
  - **Standalone Use Case**: Similar to Demo, but allows parameter customization (e.g., VPC CIDR)
  - **Add-On Use Case**: Designed to integrate with existing infrastructure
- **NP Folder**: Templates for deploying additional Virtual Blades
---

#### 🔐 Applying SSH Keys to AWS CloudFormation Templates

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

#### 🧪 Example #1: Deploying a Demo Use Case Template

Before starting a CFT template deployment please make sure you edit the Private and Public SSH Keys for both Virtual Controller and Virtual Blade inside the templates. Currently all keys are blanked out (all zeros) so that you can see what format is needed for deployment. 

To deploy a full BreakingPoint VE environment using a CloudFormation template:

```bash
aws cloudformation create-stack \
  --stack-name BPS-Demo-Deployment \
  --template-body file://Deployment/CloudFormation/BPS-VE-FullDeployment/AWS-1-Virtual-Blade-Demo-Use-Case.json
```
---

#### 🧷 Example #2: Deploying an Add-On Use Case Template

Before starting a CFT template deployment please make sure you edit the Private and Public SSH Keys for both Virtual Controller and Virtual Blade inside the templates. Currently all keys are blanked out (all zeros) so that you can see what format is needed for deployment. 

This adds a Virtual Blade to an existing infrastructure (e.g., VPC, subnets).

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

## <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Google_Cloud_logo.svg/1920px-Google_Cloud_logo.svg.png" alt="GCP Logo" width="150"/> Google Cloud Platform (GCP)

### 🔧 Configurations

This folder contains several BPS-VE .bpt configurations that can be used on their respective instance sizes. 
We have 4 different folders: 
- C2-STANDARD-4
- C2-STANDARD-8
- C2-STANDARD-16

### 🚀 Deployment

Starting with version **11.00**, BreakingPoint VE Virtual Controller and Virtual Blade are available on the GCP Marketplace

- [Keysight BreakingPoint Virtual Edition](https://console.cloud.google.com/marketplace/product/keysight-public/keysight-breakingpoint-virtual-edition)

This product contains both the Virtual Controller and Virtual Blade as part of the product subscription.
---

#### 🔧 Prerequisites

Before you begin, ensure you have the following:
- **GCP Account**: An active GCP account with appropriate permissions.
- **GCP CLI**: Installed and configured with your credentials. Install GCP CLI
- **BreakingPoint VE License**: Ensure you have a valid license for BreakingPoint VE.
- **SSH Public and Private Pregenerated Keys**: These SSH keys will be used by the Virtual Controller and Virtual Blade VMs to communicate between each other. 
---

#### 🔒 Case Study: Why do we need SSH Public and Private Keys in the BreakingPoint VE VMs ? 

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

### Deployment Manager

##### 🔐 Applying SSH Keys to GCP Deployment Manager Templates

To enable secure access, you must configure your previously generated SSH key pair in the `metadata` --> `items` section of each instance (Virtual Controller and Virtual Blade):

- **Insert your SSH keys**: Replace the placeholder values (zeros) with your actual private and public SSH keys.
- **Maintain existing paths**: Do not modify the file paths specified in the template—these must remain unchanged.
- **Cloud-init integration**: The template uses `cloud-init` to inject the SSH keys into the virtual machines during initialization.
- **Important**: If the SSH keys are not correctly applied, the attach operation will fail.

``` yaml
    metadata:
      items:
      [...]
      - key: user-data
        value: |
          #cloud-config
          write_files:
            - path: /home/ixia/.ssh/id_rsa
              permissions: '0400'
              owner: ixia:ixia
              content: |
                -----BEGIN OPENSSH PRIVATE KEY-----
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000000000
                jeHzbTtajtEAAAARdmxhZGNhbG9AdmxhZGNhbG8BAg==
                -----END OPENSSH PRIVATE KEY-----
          
            - path: /home/ixia/.ssh/id_rsa.pub
              permissions: '0600'
              owner: ixia:ixia
              content: |
                ssh-rsa 00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 user@user
          
            - path: /home/ixia/.ssh/authorized_keys
              permissions: '0644'
              owner: ixia:ixia
              content: |
                ssh-rsa 00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 user@user
          
          runcmd:
            - [ chmod, 755, /home/ixia/.ssh ]
            - [ chown, ixia:ixia, /home/ixia/.ssh ]		
```

Located in `google-cloud-platform/Deployment/DeploymentManager`, these JSON templates are organized into:

  - **Demo Use Case**: Full deployment including networking, security groups, etc.
  - **Add-On Use Case**: Designed to integrate with existing infrastructure
---

Deployment of these templates can be done through the Google Cloud Platform Cloud Shell. 
Before starting the deployment please upload your .jinja and .jinja.schema files to your Cloud Shell machine.

The following command should be executed to run a deployment: 

  ```bash
  gcloud deployment-manager deployments create DEPLOYMENT-NAME --template -GCP-1-Virtual-Blade-Demo-Use-Case-DM-Template.jinja
  ```

The status of the deployment will be displayed when the deployment will finish. 

#### <img src="https://www.vectorlogo.zone/logos/terraformio/terraformio-icon.svg" width="30" alt="Terraform logo"> Terraform Templates

Welcome to the guide for deploying **BreakingPoint VE** using Terraform templates on GCP. This document provides step-by-step instructions, example commands, and best practices for a successful deployment.

### 🔧 Prerequisites

Before you begin, ensure you have the following (additionally on top of top prerequisites):

- [Terraform](https://www.terraform.io/downloads.html) (v1.0+)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) (gcloud CLI)
- [Git](https://git-scm.com/downloads)
- Text editor (VS Code recommended)
---

### 🛠️ Setup

#### 1. 🔧 Clone the Repository

Clone the BreakingPoint VE Terraform templates repository to your local machine:

```bash
git clone https://github.com/Keysight/bpsve.git
cd google-cloud-platform/Deployment/Terraform/
```
#### 🔐 2. Install Google Cloud SDK

```bash
# For Ubuntu/Debian
curl https://sdk.cloud.google.com | bash
exec -l $SHELL

# For macOS (using Homebrew)
brew install --cask google-cloud-sdk

# For Windows, download from: https://cloud.google.com/sdk/docs/install
```

#### 3. Authenticate with Google Cloud
```bash
# Login to your Google account
gcloud auth login

# Set up application default credentials for Terraform
gcloud auth application-default login

# Verify authentication
gcloud auth list
```

#### 4. Create and Configure GCP Project
```bash
# Create a new project (optional)
gcloud projects create my-terraform-project-$(date +%s) --name="Terraform Demo Project"

# Set the project ID (replace with your project ID)
export PROJECT_ID="your-project-id"
gcloud config set project $PROJECT_ID

# Enable required APIs
gcloud services enable compute.googleapis.com
gcloud services enable sqladmin.googleapis.com
gcloud services enable servicenetworking.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
```

#### 🌍 5. Initialize Terraform
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
- Use Terraform workspaces if managing multiple environments (e.g., dev, staging, prod).

### Cloud Shell
Contains two bash scripts that can help you create or delete network peering between two VPCs. 
You will need to provide the following parameters:
- Region name
- Login ID Tag
- Project Tag
- Verbose Output

## <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/AlibabaCloudLogo.svg/1920px-AlibabaCloudLogo.svg.png" alt="Alibaba Logo" width="150"/> Alibaba Cloud

This repository contains a collection of YAML templates for deploying infrastructure and applications on Alibaba Cloud using  **Resource Orchestration Service (ROS)**.
---

### 📦 Contents
- `alibaba/` – Templates for Alibaba Cloud ROS (e.g., ECS, VPC, RDS)
---

### 🛠️ Prerequisites

- An active [Alibaba Cloud account](httpss to the [ROS Consoleor [ACK Console- Properly configured [Alibaba Cloud CLI](https://www.alibabaclInstructions
- Virtual Controller and Virtual Blade QCOW2 images uploaded into the Alibaba Cloud account

### Deploying ROS Templates

This template deploys one Virtual Controller with the following characteristics:
- 8 GB RAM
- 4 vCPUs
- 30 GB Disk
- One management interface 

```bash
aliyun ros CreateStack \
  --StackName my-stack \
  --TemplateBody file://ansible/Ixia_BreakingPoint_Virtual_Controller_Alibaba_ROS_Template.yaml
```

This template deploys one Virtual Blade with the following characteristics:
- 8 GB RAM
- 4 vCPUs
- 10 GB Disk
- One management interface (for test interfaces please use UI to attach more interfaces )

```bash
aliyun ros CreateStack \
  --StackName my-stack \
  --TemplateBody file://ansible/Ixia_BreakingPoint_Virtual_Blade_Alibaba_ROS_Template.yaml
```

## <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/OpenStack%C2%AE_Logo_2016.svg/1920px-OpenStack%C2%AE_Logo_2016.svg.png" alt="OpenStack Logo" width="80"/> OpenStack

### Introduction 
For OpenStack private cloud we provide Heat templates that can be used to deploy one BreakingPoint VE Virtual Controller and one BreakingPoint VE Virtual Blade. 

### 🔧 Prerequisites

Before getting started, make sure you have the following in place:

- **BreakingPoint VE License**: A valid license for BreakingPoint VE is required.
- **Image Uploads**: The BreakingPoint VE Virtual Controller and Virtual Blade `.qcow2` images must be extracted and uploaded to the OpenStack Glance image service.
- **Flavor Configuration**: Create the following flavors in OpenStack for the respective components:
  - **Virtual Controller**: 8 GB RAM, 4 vCPUs, 30 GB disk
  - **Virtual Blade**: 8 GB RAM, 4 vCPUs, 10 GB disk

---

## Specialized knowledge
Before you deploy these templates, we recommend that you become familiar with the following notions:
- [OpenStack Flavors] https://docs.openstack.org/nova/rocky/user/flavors.html
- [OpenStack Glance Image Service] https://docs.openstack.org/glance/latest/
- [OpenStack Nova Compute Service] https://docs.openstack.org/nova/latest/
- [OpenStack Heat Templates] https://docs.openstack.org/heat/latest/
**Note:** If you are new to OpenStack, see [Getting Started with OpenStack](https://www.openstack.org/software/start/).