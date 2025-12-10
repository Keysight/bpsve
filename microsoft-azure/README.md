# About BreakingPoint VE Azure ARM Templates
## Introduction
Welcome to the BreakingPoint VE repository for Keysight BreakingPoint VE ARM templates for deploying BreakingPoint VE with Azure portal.

To start using BreakingPoint VE's ARM templates, please refer the **README** files in each individual directory and decide on which template to start with from the below list. 

## Prerequisites
The prerequisites are:
- For existing VNET deployment, an existing VNET, two existing subnets in that VNET (one for test and one for Management) and existing security groups for BreakingPoint VE Virtual Controller and Virtual Blade.

### Specialized knowledge
Before you deploy this Custom ARM template, we recommend that you become familiar with the following Azure services:
- [Deploy resources from custom template](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-portal#deploy-resources-from-custom-template)
- [ARM Template](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/overview)
- [Azure Resource Groups](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal)
- [Azure Virtual Network](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)
- [Azure Virtual Machines](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal)

**Note:** If you are new to Azure, see [Getting Started with Azure](https://azure.microsoft.com/en-in/get-started/).


## Supported Instance Types
Only the following instance sizes are supported for both BreakingPoint VE Virtual Controller and Virtual Blade:
- `Standard_E8_v4`
- `Standard_E16_v4`

  
Following is an explanation of the configuration templates that we provide: 

## Configurations

This folder contains several BPS-VE .bpt configurations that can be used on their respective instance sizes. 
We have 4 different folders: 
- Standard_F4s / Standard_F4s_v2
- Standard_F8s / Standard_F8s_v2
- Standard_F16s / Standard_F16s_v2

## Deployment
### Azure CLI
Since BPS-VE is not posted in the Microsoft Azure Marketplace we rely on sharing the Virtual Controller and Virtual Blade with you using Public Blobs.
This folder contains a bash script that you should run from your own Linux box. 
Prerequisites include having an Azure subscription and a destination resource group (including a destination storage account name). 

The script needs to be executed as following:
  ```
  ./BreakingPoint_Prepare_VMImages_Azure_CLI_Script.bash <destination-resource-group-name> <destination-storage-account-name>
  ```

This will copy the blobs from our account to yours and it will create a Azure Image with the Virtual Controller and Virtual Blade that you may use in your further testing (and in the ARM templates). 

### AzureResourceManager
Contains two folders: 
- BPS
    - Contains ARM templates for deployment of the Virtual Controller and Virtual Blade together
    - The templates are sepparated between three types of use cases:
        - Add-on Use Case - a type of deployment that takes advantage of an existing environment (e.g. an existing VPC, subnets, firewalls etc)
        - Demo Use Case - a type of deployment that deploys a full environment (including VPC, subnets, firewalls etc)
        - Fortinet DUT - a custom template for deployment of a BPS-VE setup and a Fortinet Instance (an instance reference needs to be added for this template to work)
        - Microsoft ALB - a custom template for deployment of a BPS-VE setup and a Microsoft Instance (an instance reference needs to be added for this template to work)
        - 1 / 2 / 4 / 8 / 12 number of Virtual Blades inside the configuration
- NP
    - Contains ARM templates for deployment of the Virtual Blade only
    - The templates are sepparated between three types of use cases:
        - Add-on Use Case - a type of deployment that takes advantage of an existing environment (e.g. an existing VPC, subnets, firewalls etc)
        - Demo Use Case - a type of deployment that deploys a full environment (including VPC, subnets, firewalls etc)

Please open the Cloud Shell under your Azure subscription. 
The following command should be executed to run a deployment: 
  ```
  az deployment group create --name DEPLOYMENY-NAME --resource-group RESOURCE-GROUP-NAME --template-file BPS_on_Azure_1-vBlade_Add-On_Use_Case_ARM_Template.json --parameters PARAMETERS-FILE.json
  ```

## <img src="https://upload.wikimedia.org/wikipedia/commons/a/a8/Microsoft_Azure_Logo.svg" alt="Azure Logo" width="150"/> Microsoft Azure

### Subscription Requirement

Before deploying BreakingPoint Virtual Edition, ensure that you have subscribed to the product in the Azure Marketplace. The product will be available under the BreakingPoint Virtual Edition category. Subscribing to the product is a prerequisite for deployment.

---

### 🔧 Configurations

This folder contains several BPS-VE `.bpt` configurations that can be used on their respective instance sizes. 
We have configurations for the following instance types:
- Standard_F4s
- Standard_F8s
- Standard_F16s

### 🚀 Deployment

Starting with version **11.00**, BreakingPoint Virtual Edition Virtual Controller and Virtual Blade will be available under the BreakingPoint Virtual Edition product in the Azure Marketplace.

This product contains both the Virtual Controller and Virtual Blade as part of the product subscription.

---

#### 🔧 Prerequisites

Before you begin, ensure you have the following:
- **Azure Account**: An active Azure account with appropriate permissions.
- **Azure CLI**: Installed and configured with your credentials.
- **BreakingPoint VE License**: Ensure you have a valid license for BreakingPoint Virtual Edition.
- **SSH Public and Private Pregenerated Keys**: These SSH keys will be used by the Virtual Controller and Virtual Blade VMs to communicate between each other.

---

#### 🔒 Why do we need SSH Public and Private Keys in the BreakingPoint Virtual Edition VMs?

The Virtual Controller acts as a Virtual Blade manager and needs to communicate with one or more Virtual Blades to be able to attach the Virtual Blades to the Virtual Controller and run your tests.

Instead of using static SSH keys residing on the Virtual Controller and Virtual Blade, we rely on the end user to add those SSH keys at deployment time.

#### 🔑 How do we generate SSH Keys to use in Microsoft Azure?

##### ❓ What are SSH Keys?

SSH keys are a pair of cryptographic keys used for secure authentication:
- **Private Key**: Kept secret on your local machine
- **Public Key**: Shared with servers you want to access

To generate SSH keys, you can use the following command on your local machine:

```bash
ssh-keygen -t rsa -b 2048 -f azure_ssh_key
```

This will create two files:
- `azure_ssh_key` (Private Key)
- `azure_ssh_key.pub` (Public Key)

Use the public key during the deployment process in Azure.

---

### 🗝️ Setting SSH Keys in ARM Templates

When deploying BreakingPoint VE using the Azure ARM template, you must provide your SSH public and private keys:

- **SshPublicKey**: Paste the contents of your public key (e.g., from `azure_ssh_key.pub`, `id_rsa.pub`, or PuTTYgen) into this parameter. This key will be injected into `/home/ixia/.ssh/authorized_keys` and `/home/ixia/.ssh/id_rsa.pub` on the VM.
- **SshPrivateKey**: Paste the contents of your private key (e.g., from `azure_ssh_key`, `id_rsa`, or converted PuTTY `.ppk` to OpenSSH format) into this parameter. This key will be injected into `/home/ixia/.ssh/id_rsa` on the VM.

Both keys are required for secure communication between the Virtual Controller and Virtual Blade. Do not use placeholder values—replace them with your actual keys before deployment. The template will automatically configure file permissions and ownership using cloud-init.

**Example (Azure CLI):**
```powershell
az deployment group create \
  --resource-group <your-resource-group> \
  --template-file Azure-1-Virtual-Blade-Demo-Use-Case-ARM-Template.json \
  --parameters SshPublicKey="$(cat ~/.ssh/azure_ssh_key.pub)" SshPrivateKey="$(cat ~/.ssh/azure_ssh_key)"
```

**Note:** If using the Azure Portal, paste the full contents of each key into the corresponding parameter field when prompted.

