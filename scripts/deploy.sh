#!/bin/bash

# Export AWS credentials
export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)
export AWS_REGION=$(aws configure get region)

# Run Terraform commands
terraform init
terraform validate
terraform apply -auto-approve
