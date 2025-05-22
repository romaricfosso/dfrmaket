
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
