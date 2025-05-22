# modules/kms/variables.tf

variable "description" {
  description = "Description de la clé KMS"
  type        = string
}

variable "alias_name" {
  description = "Nom de l'alias KMS (sans prefix 'alias/')"
  type        = string
}

variable "tags" {
  description = "Tags communs"
  type        = map(string)
}
