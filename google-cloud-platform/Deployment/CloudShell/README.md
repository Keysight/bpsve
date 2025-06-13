# GCP VPC Network Peering Automation Scripts

This repository contains two Bash scripts designed to automate the deployment and cleanup of VPC Network Peering connections in Google Cloud Platform (GCP). These scripts are intended to be run in the Google Cloud Shell environment and are part of the Keysight BPSVE deployment process.

## 📁 Scripts Overview

### 1. `GCP_VPC_Network_Peering_Deployment_Bash_Script.bash`

**Purpose:**  
Automates the creation of VPC Network Peering connections between two GCP projects or networks.

**Key Features:**
- Prompts the user for necessary input such as project IDs, VPC network names, and region.
- Creates peering connections in both directions to ensure bidirectional communication.
- Verifies the peering status after deployment.
- Useful for setting up hybrid or multi-project GCP environments.

### 2. `GCP_VPC_Network_Peering_Cleanup_Bash_Script.bash`

**Purpose:**  
Automates the deletion of existing VPC Network Peering connections.

**Key Features:**
- Prompts the user for the same input parameters used during deployment.
- Deletes peering connections from both sides to ensure a clean removal.
- Confirms the deletion and provides status updates.

## ✅ Prerequisites

- Google Cloud SDK installed (Cloud Shell recommended)
- Proper IAM permissions to manage VPC networks and peering connections
- Enabled Compute Engine API

## 🚀 Usage

1. Open [Google Cloud Shell](https://shell.cloudtory:
   ```bash
   git clone https://github.com/Keysight/bpsve.git
   cd bpsve/google-cloud-platform/Deployment/CloudShell
   ```
3. Run the desired script:
   ```bash
   bash GCP_VPC_Network_Peering_Deployment_Bash_Script.bash
   ```
   or
   ```bash
   bash GCP_VPC_Network_Peering_Cleanup_Bash_Script.bash
   ```

## 📌 Notes

- These scripts are interactive and require user input during execution.
- Ensure that the peering names and network configurations are consistent across both projects.
