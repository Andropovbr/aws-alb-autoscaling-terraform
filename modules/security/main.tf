resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Permite HTTP de entrada para o Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name    = "alb-sg"
    Project = "aws-alb-autoscaling-terraform"
    Owner   = "André Santos"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Permite trafego HTTP do ALB para EC2"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "ec2-sg"
    Project = "aws-alb-autoscaling-terraform"
    Owner   = "André Santos"
  }
}
