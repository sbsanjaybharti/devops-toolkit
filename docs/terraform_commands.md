# Terraform Commands for AWS Infrastructure

This document contains Terraform commands commonly used for managing AWS infrastructure.

---

# Core Commands

## Initialize Terraform

```
terraform init
```

Initializes the working directory and downloads required providers (e.g., AWS provider).

## Validate Configuration

```
terraform validate
```

Checks Terraform files for syntax and configuration errors.

## Format Terraform Files

```
terraform fmt
```

Formats configuration files to standard Terraform style.

## Preview Infrastructure Changes

```
terraform plan
```

Shows what changes Terraform will make.

Optional:

```
terraform plan -out=tfplan
```

Saves the execution plan to a file.

## Apply Infrastructure Changes

```
terraform apply
```

Creates or updates AWS resources.

Optional:

```
terraform apply -auto-approve
```

Apply a saved plan:

```
terraform apply tfplan
```

## Destroy Infrastructure

```
terraform destroy
```

Deletes all resources defined in the configuration.

Optional:

```
terraform destroy -auto-approve
```

# Advanced / Useful Commands

## Target Specific Resource

```
terraform apply -target=aws_instance.example
```

Applies changes only to a specific resource.

Plan with target:

```
terraform plan -target=aws_instance.example
```

## Pass Variable Values

Using CLI variable:

```
terraform apply -var="instance_type=t2.micro"
```

Using variable file:

```
terraform apply -var-file="dev.tfvars"
```

## Show Current State

```
terraform show
```

Displays current state or saved plan.

## List Managed Resources

```
terraform state list
```

Lists resources tracked in Terraform state.

## Remove Resource from State (Without Deleting in AWS)

```
terraform state rm aws_instance.example
```

## Import Existing AWS Resource

```
terraform import aws_instance.example i-xxxxxxxxxxxx
```

Imports an existing AWS resource into Terraform state.

## Force Resource Recreation

```
terraform taint aws_instance.example
```

Marks a resource for recreation on next apply.

## Output Values

```
terraform output
```

Displays defined output variables.

## Workspaces (Multiple Environments)

Create workspace:

```
terraform workspace new dev
```

List workspaces:

```
terraform workspace list
```

Switch workspace:

```
terraform workspace select dev
```

# Recommended Workflow
```
terraform init  
terraform fmt  
terraform validate  
terraform plan  
terraform apply  
terraform destroy (when cleanup is required)
```