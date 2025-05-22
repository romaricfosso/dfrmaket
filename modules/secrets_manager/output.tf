output "secret_arn" {
  description = "ARN du secret stockant les credentials DB"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

# output "secret_value" {
#   description = "Valeur du secret (JSON décodé)"
#   value       = data.aws_secretsmanager_secret_version.db_creds.secret_string
#   sensitive   = true
# }
