output "name" {
  description = "Nom du rôle IAM"
  value       = aws_iam_role.secrets_instance_role.name
}
