
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
- Store state files securely if using remote backends
- Refer to subfolder READMEs for detailed, template-specific instructions

---