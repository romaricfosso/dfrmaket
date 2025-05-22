variable "tags" {
  description = "Tags globaux"
  type        = map(string)
  default     = {}
}
variable "role_name" {
  type        = string
  description = "Role name"
}
