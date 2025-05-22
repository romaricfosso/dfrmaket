variable "tags" {
  description = "Tags à appliquer à la ressource keypair"
  type        = map(string)
}

variable "key_name" {
  description = "Nom de la clé SSH (key pair EC2)"
  type        = string
}
variable "vpc_id" {
  type        = string
  description = "nom du vpc_id"
}
variable "subnet_id" {
  type        = string
  description = "nom du subnet_id"
}
