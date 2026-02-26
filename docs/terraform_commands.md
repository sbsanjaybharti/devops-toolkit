# Terraform Commands for AWS Infrastructure
This document contains Terraform commands commonly used for managing AWS infrastructure.
# Core Commands
## Initialize Terraform
```bash
terraform init          # Initialize Terraform
terraform validate      # Validate Configuration
terraform fmt           # Format Terraform Files
```
Formats configuration files to standard Terraform style.
## Preview Infrastructure Changes
```bash
terraform plan
terraform plan -out=tfplan # Shows what changes Terraform will make.
```
## Apply Infrastructure Changes
```bash
terraform apply
terraform apply -auto-approve
```
## Destroy Infrastructure
Deletes all resources defined in the configuration.
```bash
terraform destroy
```
# Advanced / Useful Commands
## Target Specific Resource
```bash
# Target Specific Resource
terraform apply -target=aws_instance.example 
# Applies changes only to a specific resource.
terraform plan -target=aws_instance.example
# Pass Variable Values
terraform apply -var="instance_type=t2.micro"
# Using variable file:
terraform apply -var-file="dev.tfvars"
```
## Show Current State
```bash
terraform show
# List Managed Resources
terraform state list
# Remove Resource from State (Without Deleting in AWS)
terraform state rm aws_instance.example
```
## Import Existing AWS Resource
```bash
terraform import aws_instance.example i-xxxxxxxxxxxx
```
Imports an existing AWS resource into Terraform state.
## Force Resource Recreation
```bash
terraform taint aws_instance.example
```
Marks a resource for recreation on next apply.
## Output Values
```bash
terraform output
```
Displays defined output variables.
## Workspaces (Multiple Environments)
```bash
terraform workspace new dev         #Create workspace
terraform workspace list            # List workspaces
terraform workspace select dev      # Switch workspace
```
# Recommended Workflow
```bash
terraform init  
terraform fmt  
terraform validate  
terraform plan  
terraform apply  
terraform destroy (when cleanup is required)
```