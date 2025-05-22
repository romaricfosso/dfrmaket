variable "db_name" {
  type        = string
  description = "Nom de la base de données"
}

variable "db_username" {
  type        = string
  description = "Utilisateur principal"
}

variable "db_password" {
  type        = string
  description = "Mot de passe"
  sensitive   = true
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "kms_key_id" {
  type = string
}

variable "sg_rds_id" {
  type        = string
  description = "ID du Security Group autorisé à accéder à RDS"
}

variable "tags" {
  type = map(string)
}
