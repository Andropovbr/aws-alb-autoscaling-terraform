variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
}

variable "public_subnets" {
  description = "Lista de CIDRs das subnets públicas"
  type        = list(string)
}

variable "private_subnets" {
  description = "Lista de CIDRs das subnets privadas"
  type        = list(string)
}

variable "azs" {
  description = "Zonas de disponibilidade"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID para a instância EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
}

variable "key_name" {
  description = "Nome da chave SSH para acesso à EC2"
  type        = string
}
