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
- **SSH Public and Private Pre-generated Keys**: These SSH keys will be used by the Virtual Controller and Virtual Blade VMs to communicate between each other. 
---

#### 🔒 Why do we need SSH Public and Private Keys in the BreakingPoint Virtual Edition VMs ? 

The Virtual Controller acts as a Virtual Blade manager and needs to communicate with one or more Virtual Blades to be able to attach the Virtual Blades to the Virtual Controller and run your tests. 

Instead of using static SSH keys residing on the Virtual Controller and Virtual Blade, we rely on the end user to add those SSH keys at deployment time.

#### 🔑 How do we generate SSH Keys to use in Google Cloud Platform ? 

##### ❓ What are SSH Keys?

SSH keys are a pair of cryptographic keys used for secure authentication:
- **Private Key**: Kept secret on your local machine
- **Public Key**: Shared with servers you want to access
---
#### Generating SSH Keys from a Linux Environment

###### Prerequisites
Most Linux distributions come with OpenSSH pre-installed. If not, install it:

```bash
# Ubuntu/Debian
sudo apt update && sudo apt install openssh-client

# CentOS/RHEL/Fedora
sudo yum install openssh-clients
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

###### Viewing Generated Keys

```bash
# List keys in SSH directory
ls -la ~/.ssh/

# View public key content
cat ~/.ssh/id_rsa.pub

# View private key content
cat ~/.ssh/id_rsa
```

---
### Generating SSH Keys from a Windows Environment

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
### Generating SSH Keys from Google Cloud

#### 🖥️ Using Google Cloud Shell

1. **Open Cloud Shell**  
   Click the terminal icon in the top-right corner of the Google Cloud Console.

2. **Generate SSH Key Pair**

   Run the following command:

   ```bash
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/gcp_key -C "your-email@example.com"
   ```

   - `-t rsa`: Specifies the RSA algorithm.
   - `-b 4096`: Sets the key length to 4096 bits.
   - `-f ~/.ssh/gcp_key`: Defines the output file name and location.
   - `-C`: Adds a comment (usually your email).

   When prompted:
   - Press `Enter` to accept the default location.
   - Optionally enter a passphrase for added security.

3. **View Your Keys**

   ```bash
   cat ~/.ssh/gcp_key.pub   # Public key
   cat ~/.ssh/gcp_key       # Private key
   ```

4. **Add Public Key to VM Metadata**

   - Go to **Compute Engine > Metadata > SSH Keys**
   - Click **Edit** and paste the contents of `gcp_key.pub`
   - Click **Save**

✅ You can now use the private key to SSH into your VM from other systems or tools.

## 🔐 Applying SSH Keys to Google Cloud Deployment Manager Templates

To enable secure access, you must configure your previously generated SSH key pair in the `metadata` section of each instance (Virtual Controller and Virtual Blade):

- **Insert your SSH keys**: Replace the placeholder values (zeros) with your actual private and public SSH keys.
- **Maintain existing paths**: Do not modify the file paths specified in the template—these must remain unchanged.
- **Cloud-init integration**: The template uses `cloud-init` to inject the SSH keys into the virtual machines during initialization.
- **Important**: If the SSH keys are not correctly applied, the Virtual Blade attach operation to the Virtual Controller will fail.

Below SSH keys have been intentionally zeroed out due to security reasons. Please replace them with your own SSH key values.

``` yaml
    metadata:
      items:
      - key: Owner 
        value: {{ properties["GCP_OWNER_TAG"] }}
      - key: Project
        value: {{ properties["GCP_PROJECT_TAG"] }}
      - key: Options
        value: {{ properties["GCP_OPTIONS_TAG"] }}
      - key: serial-port-enable
        value: {{ properties["GCP_VBLADE_SERIAL_PORT_ENABLE"] }}
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
						"      ssh-rsa 00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 user@user\n",
          
            - path: /home/ixia/.ssh/authorized_keys
              permissions: '0644'
              owner: ixia:ixia
              content: |
						"      ssh-rsa 00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 user@user\n",
          
          runcmd:
            - [ chmod, 755, /home/ixia/.ssh ]
            - [ chown, ixia:ixia, /home/ixia/.ssh ]		
```

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