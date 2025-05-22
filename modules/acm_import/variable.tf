variable "certificate_arn" {
  description = "ARN du certificat ACM à valider"
  type        = string
}

variable "validation_record_name" {
  description = "Nom DNS de validation (ex: _abcde.domaine.com)"
  type        = string
}

variable "validation_record_type" {
  description = "Type d'enregistrement DNS (TXT ou CNAME)"
  type        = string
  default     = "CNAME"
}

variable "validation_record_value" {
  description = "Valeur de l'enregistrement DNS"
  type        = string
}

variable "zone_id" {
  description = "ID de la zone Route 53"
  type        = string
}
variable "domain_name" {
  description = "Nom de domaine à protéger (ex: wordpress.clouddream.com)"
  type        = string
}

# variable "ssl_policy" {
#   description = "Politique SSL pour HTTPS"
#   type        = string
#   default     = "ELBSecurityPolicy-2016-08"
# }

variable "tags" {
  description = "Tags communs"
  type        = map(string)
}
