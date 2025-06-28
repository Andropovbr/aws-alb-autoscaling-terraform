variable "public_subnet_ids" {
  description = "IDs das subnets públicas para o ALB"
  type        = list(string)
}

variable "lb_sg_id" {
  description = "ID do security group associado ao ALB"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "target_group_arns" {
  description = "Lista de ARNs do Target Group do ALB"
  type        = list(string)
}
