output "vpc_id" {
  description = "ID da VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs das sub-redes públicas"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  description = "IDs das sub-redes privadas"
  value       = [for subnet in aws_subnet.private : subnet.id]
}
