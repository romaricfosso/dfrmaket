resource "aws_db_subnet_group" "this" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags       = var.tags
}
resource "aws_db_instance" "this" {
  identifier                = "dfritech-instance"
  engine                    = "mysql"
  engine_version            = "8.0.32"
  instance_class            = "db.t3.micro"
  storage_type              = "gp3"
  allocated_storage         = 20
  db_name                   = var.db_name
  username                  = var.db_username
  password                  = var.db_password
  db_subnet_group_name      = aws_db_subnet_group.this.name
  vpc_security_group_ids    = [var.sg_rds_id]
  multi_az                  = true
  publicly_accessible       = false
  skip_final_snapshot       = false
  final_snapshot_identifier = "dfritech-final-snapshot"
  deletion_protection       = false
  backup_retention_period   = 7
  storage_encrypted         = true
  kms_key_id                = var.kms_key_id

  lifecycle {
    prevent_destroy = false
    ignore_changes = [
      engine_version,
      allocated_storage,
      password
    ]
  }

  tags = var.tags
}
