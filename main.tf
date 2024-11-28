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

# Internet Gateway
resource "aws_internet_gateway" "lab_igw" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name = "Lab-Internet-Gateway"
  }
}

# Route Table
resource "aws_route_table" "lab_route_table" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_igw.id
  }

  tags = {
    Name = "Lab-Route-Table"
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

# Route Table Association
resource "aws_route_table_association" "lab_route_table_assoc" {
  subnet_id      = aws_subnet.lab_subnet.id
  route_table_id = aws_route_table.lab_route_table.id
}

# Security Group
resource "aws_security_group" "lab_sg" {
  vpc_id = aws_vpc.lab_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Lab-Security-Group"
  }
}

# EC2 Instance with Nginx
resource "aws_instance" "ubuntu_nginx" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.lab_subnet.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.lab_sg.name]

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

# Outputs
output "public_ip" {
  value = aws_instance.ubuntu_nginx.public_ip
}

output "subnet_id" {
  value = aws_subnet.lab_subnet.id
}

output "vpc_id" {
  value = aws_vpc.lab_vpc.id
}
