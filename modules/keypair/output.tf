output "key_name" {
  description = "Nom de la clé créée"
  value       = aws_key_pair.dfritech.key_name
}

output "private_key_pem" {
  description = "Clé privée si générée par Terraform"
  value       = try(tls_private_key.dfritech.private_key_pem, null)
  sensitive   = true
}
