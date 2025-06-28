terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "us-east-1"
}

module "network" {
  source          = "./modules/network"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}

module "compute" {
  source = "./modules/compute"

  private_subnet_ids      = module.network.private_subnet_ids
  ec2_security_group_id   = module.security.ec2_sg_id
  ami_id                  = var.ami_id
  instance_type           = var.instance_type
  key_name                = var.key_name
  target_group_arns       = [module.alb.target_group_arn]
  instance_profile_name   = module.compute.instance_profile_name

}


module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}

module "alb" {
  source            = "./modules/alb"
  public_subnet_ids = module.network.public_subnet_ids
  lb_sg_id          = module.security.alb_sg_id
  vpc_id            = module.network.vpc_id
  target_group_arns = [module.alb.target_group_arn]
}
