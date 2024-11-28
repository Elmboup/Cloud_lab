output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.lab_vpc.id
}

output "subnet_id" {
  description = "ID of the created Subnet"
  value       = aws_subnet.lab_subnet.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.ubuntu_nginx.public_ip
}
