output "db_host" {
  description = "Adresse endpoint de la base RDS"
  value       = aws_db_instance.this.endpoint
}
