output "target_group_arn" {
  description = "ARN du Target Group ALB (à utiliser dans l'ASG)"
  value       = aws_lb_target_group.this.arn
}

output "sg_id" {
  description = "ID du Security Group ALB (si besoin de le réutiliser)"
  value       = var.sg_alb_id
}

output "dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.this.dns_name
}

output "zone_id" {
  description = "Zone ID of the load balancer"
  value       = aws_lb.this.zone_id
}

