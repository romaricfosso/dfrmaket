# modules/kms/main.tf

resource "aws_kms_key" "this" {
  description             = var.description
  deletion_window_in_days = 10
  enable_key_rotation     = true
  tags                    = merge(var.tags, { Name = var.alias_name })
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.alias_name}"
  target_key_id = aws_kms_key.this.key_id
}
