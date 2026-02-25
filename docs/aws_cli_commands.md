## AWS CLI Commands Reference Document
### Basic Setup & Configuration
```bash
aws --version
aws configure
aws configure list
aws help
```
### IAM & Security
```bash
aws sts get-caller-identity
aws iam list-attached-user-policies --output table
aws iam list-roles --output table
aws iam create-user --user-name <username>
aws iam delete-user --user-name <username>
aws iam attach-user-policy --user-name <username> --policy-arn <policy-arn>
aws iam detach-user-policy --user-name <username> --policy-arn <policy-arn>
```
### EC2 Instance Management
```bash
# Describe instances
aws ec2 describe-instances
aws ec2 describe-instances --output table
aws ec2 describe-instances \
    --query 'Reservations[].Instances[?State.Name==`running`].[InstanceId,PublicIpAddress]' \
    --output table
aws ec2 describe-instances \
    --filters "Name=instance-state-name,Values=running" \
    --query "Reservations[*].Instances[*].[InstanceType,PublicIpAddress,PrivateIpAddress]" \
    --output table
aws ec2 describe-instances \
    --region <region> \
    --filters "Name=instance-state-name,Values=running" \
    --output table
aws ec2 describe-instances \
    --query "Reservations[*].Instances[*]" \
    --output text
# Launch instances
aws ec2 run-instances \
    --image-id <ami-id> \
    --instance-type <instance-type> \
    --key-name <key-pair> \
    --security-group-ids <security-group> \
    --subnet-id <subnet-id>
# Terminate instances
aws ec2 terminate-instances --instance-ids <instance-id>
aws ec2 wait instance-terminated --instance-ids <instance-id>
# Stop/Start instances
aws ec2 stop-instances --instance-ids <instance-id>
aws ec2 start-instances --instance-ids <instance-id>
```
### Key Pairs
```bash
aws ec2 describe-key-pairs --output table
aws ec2 create-key-pair --key-name <key-pair> --query "KeyMaterial" --output text > <key-pair>.pem
chmod 400 <key-pair>.pem
aws ec2 delete-key-pair --key-name <key-pair>
```
### AWS EKS
```bash
aws eks update-kubeconfig --name <cluster_name>
```
### Security Groups & VPC
```bash
# Security Groups
aws ec2 create-security-group \
    --group-name <sg-name> \
    --description "security-group-testing" \
    --vpc-id <vpc-id>
aws ec2 authorize-security-group-ingress \
    --group-id <sg-id> \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress \
    --group-id <sg-id> \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0
aws ec2 describe-security-groups --output table
aws ec2 delete-security-group --group-id <sg-id>
# VPC & Subnet
aws ec2 create-vpc \
    --cidr-block 10.0.0.0/16 \
    --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=<vpc-name>}]'
aws ec2 describe-vpcs --output table
aws ec2 create-subnet --vpc-id <vpc-id> --cidr-block 10.0.1.0/24
aws ec2 delete-subnet --subnet-id <subnet-id>
aws ec2 delete-vpc --vpc-id <vpc-id>
```
### AMI Images
```bash
aws ec2 describe-images \
    --owners amazon \
    --filters "Name=name,Values=al2023-ami-*" "Name=architecture,Values=x86_64" "Name=root-device-type,Values=ebs" \
    --query "Images[*].[ImageId,Name]" \
    --output table
```
### S3 Bucket Management
```bash
aws s3 ls
aws s3 mb s3://<bucket-name>
aws s3 cp <file> s3://<bucket-name>/
aws s3 rb s3://<bucket-name> --force
aws s3 sync ./local-folder s3://<bucket-name>/
aws s3 sync s3://<bucket-name>/ ./local-folder
```
### Miscellaneous Useful AWS CLI Commands
```bash
# CloudWatch Logs
aws logs describe-log-groups
aws logs describe-log-streams --log-group-name <log-group>
aws logs get-log-events --log-group-name <log-group> --log-stream-name <log-stream>
# Lambda
aws lambda list-functions
aws lambda invoke --function-name <function-name> output.txt
# CloudFormation
aws cloudformation list-stacks
aws cloudformation describe-stacks --stack-name <stack-name>
```