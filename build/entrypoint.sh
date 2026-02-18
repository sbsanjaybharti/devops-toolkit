#!/bin/bash
echo "AWS configuration"
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set region $AWS_DEFAULT_REGION
aws configure set output 'json'

# aws eks --region $AWS_DEFAULT_REGION update-kubeconfig --name kraken-$ENV
# echo aws eks --region $AWS_DEFAULT_REGION update-kubeconfig --name kraken-$ENV
# RED='\033[0;31m'
# GREEN='\033[0;32m'
# NC='\033[0m' # No Color
######################################################
# New setup
######################################################
set -e

if [ -z "$ENV" ]; then
  echo "ENV variable is not set (e.g., staging or production)"
  exit 1
fi

# Verify AWS CLI
if ! command -v aws &> /dev/null
then
    echo "AWS CLI not found!"
    exit 1
fi

# Configure AWS if environment variables exist
if [[ -n "$AWS_ACCESS_KEY_ID" && -n "$AWS_SECRET_ACCESS_KEY" ]]; then
    echo "Configuring AWS CLI using environment variables..."

    mkdir -p /root/.aws

    cat > /root/.aws/credentials <<EOF
[default]
aws_access_key_id=${AWS_ACCESS_KEY_ID}
aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}
EOF

    cat > /root/.aws/config <<EOF
[default]
region=${AWS_DEFAULT_REGION}
output=json
[profile dev-role]
role_arn=${AWS_ASSUME_ROLE_ARN}
source_profile=default

EOF
fi

# ---------------------------------------
# Validate AWS authentication (optional)
# ---------------------------------------
if aws sts get-caller-identity &> /dev/null; then
    echo "AWS authentication successful."
else
    echo "AWS credentials not configured or invalid."
fi

echo "Environment ready."
echo "-----------------------------------"

exec "$@"

# # Variable
# TFVARS_FILE="envs/terraform.tfvars.$ENV"
# # ln -sf "$TFVARS_FILE" terraform.tfvars
# envsubst < $TFVARS_FILE > terraform.tfvars
# # echo "Linked $TFVARS_FILE -> terraform.tfvars"

# # Provider
# PROVIDER_TFVARS_FILE="envs/provider.tf.template"
# if [ ! -f "$PROVIDER_TFVARS_FILE" ]; then
#   echo "ERROR: Variable file '$PROVIDER_TFVARS_FILE' not found."
#   exit 1
# fi
# [ -f provider.tf ] && rm provider.tf
# envsubst < $PROVIDER_TFVARS_FILE > provider.tf
# echo "Linked $PROVIDER_TFVARS_FILE -> provider.tf"

# # --- Configure Terraform Cloud token if provided ---
# if [ -n "$TF_TOKEN" ]; then
#   mkdir -p /root/.terraform.d
#   cat > /root/.terraform.d/credentials.tfrc.json <<EOF
# {
#   "credentials": {
#     "app.terraform.io": {
#       "token": "$TF_TOKEN"
#     }
#   }
# }
# EOF
#   echo "Terraform Cloud token configured."
# else
#   echo "No Terraform Cloud token (TF_TOKEN) provided. Skipping login setup."
# fi

# echo "Running Terraform with ENV=${ENV}"
# terraform init -upgrade
# terraform init
# # terraform workspace select kraken-${ENV}
# exec /bin/sh  # or terraform plan/apply if desired

