resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "${var.db_name}-credentials-1"
  description = "Database credentials for ${var.db_name}"
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = var.db_host
    engine   = "mysql"
    dbname   = var.db_name
  })
}
