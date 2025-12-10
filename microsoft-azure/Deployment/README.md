---

## 🗝️ Setting SSH Keys in ARM Templates

When deploying BreakingPoint VE using the Azure ARM template, you must provide your SSH public and private keys:

- **SshPublicKey**: Paste the contents of your public key (e.g., from `id_rsa.pub` or PuTTYgen) into this parameter. This key will be injected into `/home/ixia/.ssh/authorized_keys` and `/home/ixia/.ssh/id_rsa.pub` on the VM.
- **SshPrivateKey**: Paste the contents of your private key (e.g., from `id_rsa` or converted PuTTY `.ppk` to OpenSSH format) into this parameter. This key will be injected into `/home/ixia/.ssh/id_rsa` on the VM.

Both keys are required for secure communication between the Virtual Controller and Virtual Blade. Do not use placeholder values—replace them with your actual keys before deployment. The template will automatically configure file permissions and ownership using cloud-init.

**Example (Azure CLI):**
```powershell
az deployment group create \
	--resource-group <your-resource-group> \
	--template-file Azure-1-Virtual-Blade-Demo-Use-Case-ARM-Template.json \
	--parameters SshPublicKey="$(cat ~/.ssh/id_rsa.pub)" SshPrivateKey="$(cat ~/.ssh/id_rsa)"
```

**Note:** If using the Azure Portal, paste the full contents of each key into the corresponding parameter field when prompted.
## <img src="https://upload.wikimedia.org/wikipedia/commons/a/a8/Microsoft_Azure_Logo.svg" alt="Azure Logo" width="80"/> Microsoft Azure

---

### 📦 Contents
- `AzureResourceManager/` – ARM templates for deploying BreakingPoint VE resources
- `Terraform/` – Terraform templates for infrastructure automation
- `Azure CLI/` – Scripts for VM image preparation and resource setup

---

### 🔧 Prerequisites

Before deploying BreakingPoint Virtual Edition on Azure, ensure you have:
- Subscribed to BreakingPoint Virtual Edition in the [Azure Marketplace](https://azuremarketplace.microsoft.com/)
- An active Azure account with sufficient permissions
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed
- [Terraform](https://www.terraform.io/downloads.html) (if using Terraform)
- [Git](https://git-scm.com/downloads) for cloning repositories

---

### 🛠️ Setup

#### 1. 🔧 Clone the Repository

```powershell
git clone https://github.com/Keysight/bpsve.git
cd microsoft-azure/Deployment/
```

#### 2. 🔐 Authenticate with Azure

```powershell
az login
```

#### 3. 🌍 Prepare Resources
- For ARM: Review and edit parameters in the templates under `AzureResourceManager/`
- For Terraform: Initialize and configure your environment in `Terraform/`

#### 4. 🚀 Deploy BreakingPoint VE
- **ARM**: Deploy using Azure Portal or Azure CLI:
	```powershell
	az deployment group create --resource-group <your-resource-group> --template-file <template.json>
	```
- **Terraform**:
	```powershell
	terraform init
	terraform apply -auto-approve
	```

---

### 📋 Notes
- Ensure your subscription includes BreakingPoint VE before deploying
- Edit SSH keys and parameters as needed in templates
- Store state files securely if using remote backends
- Refer to subfolder READMEs for detailed, template-specific instructions

---

## 🔒 Why do you need SSH keys for BreakingPoint VE VMs?

BreakingPoint VE uses SSH keys for secure communication between the Virtual Controller and Virtual Blades. You must provide your own SSH key pair during deployment to enable secure access and management. Keys are injected into the VMs using cloud-init or ARM template parameters.

---

## 🔑 How to Generate SSH Keys

### Linux (OpenSSH)

Most Linux distributions include OpenSSH. If not, install it:

```bash
# Ubuntu/Debian
sudo apt update && sudo apt install openssh-client
# CentOS/RHEL/Fedora
sudo yum install openssh-clients
# or for newer versions
sudo dnf install openssh-clients
```

Generate a key pair:
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
Press Enter to accept the default file location, and set a passphrase if desired.

View your keys:
```bash
ls -la ~/.ssh/
cat ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa
```

### Windows (PuTTY)

Download PuTTY from [putty.org](https://www.putty.org/).

Generate keys with PuTTYgen:
1. Launch PuTTYgen
2. Select RSA, set key size to 4096 bits
3. Click "Generate" and move your mouse for randomness
4. Add a comment (optional)
5. Set a passphrase (recommended)
6. Save the private key (.ppk format)
7. Copy the public key from the PuTTYgen window

Convert PuTTY keys to OpenSSH format:
```powershell
# Convert .ppk to OpenSSH private key
puttygen keyfile.ppk -O private-openssh -o keyfile
# Convert .ppk to OpenSSH public key
puttygen keyfile.ppk -O public-openssh -o keyfile.pub
```

---

## 🔐 Applying SSH Keys in Azure Templates

- **ARM Templates**: Insert your public SSH key in the `adminPublicKey` or similar parameter. Do not use placeholder values—replace them with your actual key.
- **Terraform**: Set the `admin_ssh_key` or equivalent variable to your public key. Ensure the file paths and permissions match those required by the template.
- **Cloud-init**: If using cloud-init, keys are injected into `/home/<user>/.ssh/authorized_keys` and `/home/<user>/.ssh/id_rsa.pub`. Do not modify the file paths unless instructed.

**Important:** If SSH keys are not correctly configured, you may not be able to access or manage the deployed VMs. Always verify your key format and placement before deployment.