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

Located in `aws/Deployment/Cloudformation`, these JSON templates are organized into:

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
  --template-body file://Deployment/Cloudformation/BPS/BPS-on-AWS-1-vBlade-Demo-Use-Case-CloudFormation.json
```
---

#### 🧷 Example #2: Deploying an Add-On Use Case Template

Before starting a CFT template deployment please make sure you edit the Private and Public SSH Keys for both Virtual Controller and Virtual Blade inside the templates. Currently all keys are blanked out (all zeros) so that you can see what format is needed for deployment. 

This adds a Virtual Blade to an existing infrastructure (e.g., VPC, subnets).

```bash
aws cloudformation create-stack \
  --stack-name BPS-AddOn-Deployment \
  --template-body file://Deployment/Cloudformation/BPS BPS-on-AWS-1-vBlade-Add-On-Use-Case-CloudFormation.json
```

### 📋 Notes
- Ensure the AWS CLI is configured with appropriate credentials and region.
- Replace file paths and parameter files with your actual paths if different.

---