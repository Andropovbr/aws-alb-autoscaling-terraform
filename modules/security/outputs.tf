output "alb_sg_id" {
  description = "ID do Security Group do ALB"
  value       = aws_security_group.alb_sg.id
}

output "ec2_sg_id" {
  description = "ID do Security Group das instâncias EC2"
  value       = aws_security_group.ec2_sg.id
}
