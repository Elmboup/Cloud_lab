# Terraform AWS Project

This project uses Terraform to deploy a VPC, subnet, and an EC2 instance with Nginx pre-installed. It also includes a CI/CD pipeline using GitHub Actions.

## Prerequisites
- Terraform installed
- AWS CLI installed and configured
- GitHub repository setup with secrets

## Usage
1. Update `terraform.tfvars` with your AWS credentials and configurations.
2. Run the deployment script:
   ```bash
   ./scripts/deploy.sh
