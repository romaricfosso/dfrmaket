variable "key_name" {
  description = "Nom de la clé SSH (key pair EC2)"
  type        = string
}

variable "generate_key" {
  description = "Générer une clé privée automatiquement ?"
  type        = bool
  default     = true
}

variable "public_key_path" {
  description = "Chemin vers ta clé publique locale (si generate_key = false)"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "tags" {
  description = "Tags à appliquer à la ressource keypair"
  type        = map(string)
}
