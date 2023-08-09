# bpsve
BreakingPoint Virtual Edition


# Google Cloud Platform
## Configurations 

This folder contains several BPS-VE .bpt configurations that can be used on their respective instance sizes. 
We have 4 different folders: 
    - C2-STANDARD-4
    - C2-STANDARD-8
    - C2-STANDARD-16

## Deployment
### Deployment Manager
Contains jinja and jinja.schema files that can be used to start a deployment on your Google Cloud account. 
The templates are sepparated between three types of use cases:
    - Add-on Use Case - a type of deployment that takes advantage of an existing environment (e.g. an existing VPC, subnets, firewalls etc)
    - Demo Use Case - a type of deployment that deploys a full environment (including VPC, subnets, firewalls etc)
    - Fortinet DUT - a custom template for deployment of a BPS-VE setup and a Fortinet Instance (an instance reference needs to be added for this template to work)

Deployment of these templates can be done through the Google Cloud Platform Cloud Shell. 
Before starting the deployment please upload your .jinja and .jinja and .jinja.schema files to your Cloud Shell machine.

The following command should be executed to run a deployment: 

  ```
  gcloud deployment-manager deployments create DEPLOYMENT-NAME --template BPS-on-GCP-1-vBlade-Demo-Use-Case-DM-Template.jinja
  ```

The status of the deployment will be displayed when the deployment will finish. 
