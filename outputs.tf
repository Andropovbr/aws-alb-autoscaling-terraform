output "alb_dns_name" {
  description = "DNS público do Load Balancer"
  value       = module.alb.alb_dns_name
}
