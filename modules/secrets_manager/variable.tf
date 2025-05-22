variable "db_name" {
  description = "Nom de la base de données"
  type        = string
}

variable "db_username" {
  description = "Nom d'utilisateur de la base"
  type        = string
}

variable "db_password" {
  description = "Mot de passe de la base"
  type        = string
  sensitive   = true
}

variable "db_host" {
  description = "Adresse de la base de données"
  type        = string
}

variable "tags" {
  description = "Tags communs"
  type        = map(string)
}
