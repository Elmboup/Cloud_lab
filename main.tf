provider "aws" {
  region = "eu-west-1"
}

# VPC
resource "aws_vpc" "lab_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Lab-VPC"
  }
}

# Subnet
resource "aws_subnet" "lab_subnet" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = var.subnet_cidr
  tags = {
    Name = "Lab-Subnet"
  }
}

# EC2 Instance with Nginx
resource "aws_instance" "ubuntu_nginx" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.lab_subnet.id

  associate_public_ip_address = true

  user_data = <<-EOF
                #!/bin/bash
                apt update -y
                apt install nginx -y
                systemctl start nginx
  EOF

  tags = {
    Name = "Ubuntu-Nginx"
  }
}
