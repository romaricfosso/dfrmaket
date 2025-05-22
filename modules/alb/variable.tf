variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Liste des subnets publics pour l'ALB"
  type        = list(string)
}

variable "sg_alb_id" {
  description = "Security group ID pour l'ALB"
  type        = string
}
variable "deletion_protection_enabled" {
  description = "Activer ou non la protection contre la suppression"
  type        = bool

}
# variable "certificate_arn" {
#   description = "ARN du certificat SSL (ACM)"
#   type        = string
# }

variable "domain_name" {
  description = "Nom de domaine à protéger (ex: wordpress.clouddream.com)"
  type        = string
}

variable "ssl_policy" {
  description = "Politique SSL pour HTTPS"
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

variable "tags" {
  description = "Tags communs"
  type        = map(string)
}
