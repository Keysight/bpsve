# About BreakingPoint VE Heat Templates 

## Introduction 

Welcome to the GitHub repository for Keysight BreakingPoint VE deployment guide using OpenStack Heat Templates. 

To start using BreakingPoint VE's Heat templates and yaml configuration, please refer the **README** files in each individual directory and decide on which template to start with from the below list.

## Prerequisites

The prerequisites are:
- BreakingPoint VE Virtual Controller and BreakingPoint VE Virtual Blade qcow2 images extracted and uploaded into OpenStack Glance Server (images)
- OpenStack setup and account for running your tests
- Flavors created for the BreakingPoint VE Virtual Controller and BreakingPoint VE Virtual Blade.
  - BreakingPoint VE Virtual Controller: 8GB RAM, 4vCPUs and 30GB Disk
  - BreakingPoint VE Virtual Blade: 8GB RAM, 4 vCPUs and 10GB Disk
 
## Specialized knowledge
Before you deploy these templates, we recommend that you become familiar with the following notions:
- [OpenStack Flavors] https://docs.openstack.org/nova/rocky/user/flavors.html
- [OpenStack Glance Image Service] https://docs.openstack.org/glance/latest/
- [OpenStack Nova Compute Service] https://docs.openstack.org/nova/latest/
- [OpenStack Heat Templates] https://docs.openstack.org/heat/latest/
**Note:** If you are new to OpenStack, see [Getting Started with OpenStack](https://www.openstack.org/software/start/).
