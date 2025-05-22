variable "region" {
  type        = string
  description = "nom de le région"
}
variable "vpc-name" {
  description = "Nom de la VPC"
  type        = string
}

variable "cidr-vpc" {
  description = "CIDR principal de la VPC"
  type        = string
}

variable "azs" {
  description = "Liste des zones de disponibilité"
  type        = list(string)
}

variable "public_subnets" {
  description = "Liste des subnets publics"
  type        = list(string)
}

variable "private_subnets" {
  description = "Liste des subnets privés"
  type        = list(string)
}
variable "dhcp_name" {
  type        = string
  description = "Nom du DHCP"
}
variable "tags" {
  description = "Tags globaux"
  type        = map(string)
  default     = {}
}
variable "alias_name" {
  description = "Nom de l'alias KMS (sans prefix 'alias/')"
  type        = string
}
variable "description" {
  description = "Description de la clé KMS"
  type        = string
}
variable "sg_ec2" {
  type        = string
  description = "Nom du SG pour EC2"
}
variable "sg_alb" {
  type        = string
  description = "Nom du SG pour ALB"
}
variable "sg_rds" {
  type        = string
  description = "Nom du SG pour RDS"
}
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

# variable "db_host" {
#   description = "Adresse de la base de données"
#   type        = string
# }

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t3.micro" # ou ton choix
}

variable "key_name" {
  description = "Nom de la paire de clés SSH"
  type        = string
}
variable "user_data_path" {
  type        = string
  description = "Chemin vers le script user_data WordPress"
}
# locals {
#   user_data_path = "${path.module}/user_data/wordpress.sh"
# }
variable "role_name" {
  type        = string
  description = "Nom du role pour secret manager"
}
#alb
# variable "certificate_arn" {
#   description = "ARN du certificat SSL (ACM)"
#   type        = string
# }
variable "deletion_protection_enabled" {
  description = "Activer ou non la protection contre la suppression"
  type        = bool

}

variable "domain_name" {
  description = "Nom de domaine à protéger (ex: wordpress.clouddream.com)"
  type        = string
}
variable "ssl_policy" {
  description = "Politique SSL utilisée pour l'écouteur HTTPS de l'ALB"
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}
# variable "bastion_sg_id" {
#   description = "ID du Security Group du bastion SSH"
#   type        = string
# }
