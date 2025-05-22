output "sg_ec2_id" {
  description = "ID du SG EC2"
  value       = aws_security_group.ec2.id
}

output "sg_rds_id" {
  description = "ID du SG RDS"
  value       = aws_security_group.rds.id
}

output "sg_alb_id" {
  description = "ID du SG ALB"
  value       = aws_security_group.alb.id
}

