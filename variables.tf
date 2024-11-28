variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "ami_id" {
  description = "AMI ID for the Ubuntu instance"
  default     = "ami-0d64bb532e0502c46" # Ubuntu Server 24.04 LTS (HVM)
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}
