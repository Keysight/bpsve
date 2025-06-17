## <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Google_Cloud_logo.svg/1920px-Google_Cloud_logo.svg.png" alt="GCP Logo" width="150"/> Google Cloud Platform (GCP)

### 🔧 Configurations

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
- **SSH Public and Private Pregenerated Keys**: These SSH keys will be used by the Virtual Controller and Virtual Blade VMs to communicate between each other. 
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

##### Prerequisites
Most Linux distributions come with OpenSSH pre-installed. If not, install it:

```bash
# Ubuntu/Debian
sudo apt update && sudo apt install openssh-client

# CentOS/RHEL/Fedora
sudo yum install openssh-clients
```

##### Generating SSH Keys

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

##### Viewing Generated Keys

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

✅ You can now use the private key to SSH into your VM from other systems or tools.

### 📦 Deployment Manager Templates

Located in `google-cloud-platform/Deployment/DeploymentManager`, these JINJA templates are organized into:

  - **Demo Use Case**: Full deployment including networking, security groups, etc.
  - **Add-On Use Case**: Designed to integrate with existing infrastructure
---

#### 🔐 Applying SSH Keys to Google Cloud Deployment Manager Templates

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

#### 🧪 Example #1: Deploying a Demo Use Case Template

**Purpose:**  
Before starting a CFT template deployment please make sure you edit the Private and Public SSH Keys for both Virtual Controller and Virtual Blade inside the templates. Currently all keys are blanked out (all zeros) so that you can see what format is needed for deployment. 

**Important**: If the SSH keys are not correctly applied, the Virtual Blade attach operation to the Virtual Controller will fail.

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
gcloud deployment-manager deployments create BPS-on-GCP-1-vBlade-Demo-Use-Case-DM-Template --template BPS-on-GCP-1-vBlade-Demo-Use-Case-DM-Template.jinja
```
---

#### 🧷 Example #2: Deploying an Add-On Use Case Template

**Purpose:**  
Before starting a CFT template deployment please make sure you edit the Private and Public SSH Keys for both Virtual Controller and Virtual Blade inside the templates. Currently all keys are blanked out (all zeros) so that you can see what format is needed for deployment. 

This adds a Virtual Blade and a Virtual Controller to an existing infrastructure (e.g., VPC, subnets).

**Important**: If the SSH keys are not correctly applied, the Virtual Blade attach operation to the Virtual Controller will fail.

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
gcloud deployment-manager deployments create BPS-on-GCP-1-vBlade-Add-On-Use-Case-DM-Template --template BPS-on-GCP-1-vBlade-Add-On-Use-Case-DM-Template.jinja
```