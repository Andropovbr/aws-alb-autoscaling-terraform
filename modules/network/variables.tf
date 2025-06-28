variable "vpc_cidr" {
  description = "CIDR block da VPC"
  type        = string
}

variable "azs" {
  description = "Lista de zonas de disponibilidade para sub-redes"
  type        = list(string)
}

variable "public_subnets" {
  description = "Lista de CIDRs para sub-redes públicas"
  type        = list(string)
}

variable "private_subnets" {
  description = "Lista de CIDRs para sub-redes privadas"
  type        = list(string)
}
