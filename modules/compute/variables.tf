variable "ami_id" {
  description = "AMI ID para instâncias EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
}

variable "key_name" {
  description = "Nome do par de chaves EC2"
  type        = string
}

variable "ec2_security_group_id" {
  description = "ID do Security Group para a instância EC2"
  type        = string
}

variable "private_subnet_ids" {
  description = "Lista de IDs das subnets privadas"
  type        = list(string)
}

variable "target_group_arns" {
  description = "Lista de ARNs do Target Group do ALB"
  type        = list(string)
}

variable "instance_profile_name" {
  type        = string
  description = "Nome do instance profile para associar à EC2"
}
