output "alb_dns_name" {
  description = "DNS do Application Load Balancer"
  value       = aws_lb.app.dns_name
}

output "target_group_arn" {
  description = "ARN do Target Group do ALB"
  value       = aws_lb_target_group.app.arn
}
