vpc_cidr        = "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
azs             = ["us-east-1a", "us-east-1b"]
ami_id         = "ami-05ffe3c48a9991133"  # Exemplo: Amazon Linux 2 (verifique o ID real na sua região)
instance_type  = "t2.micro"
key_name = "andre-key"
