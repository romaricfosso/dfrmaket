output "key_id" {
  description = "ID de la clé KMS"
  value       = aws_kms_key.this.key_id
}

output "key_arn" {
  description = "ARN de la clé KMS"
  value       = aws_kms_key.this.arn
}

output "alias_name" {
  description = "Nom de l'alias KMS"
  value       = aws_kms_alias.this.name
}
