
variable "tags" {
  description = "Tags globaux"
  type        = map(string)
  default     = {}
}
variable "sg_ec2" {
  type        = string
  description = "security groupe des ec2"
}
variable "sg_alb" {
  type        = string
  description = "Nom du SG pour ALB"
}
variable "sg_rds" {
  type        = string
  description = "Nom du SG pour RDS"
}

variable "vpc_id" {
  description = "ID du VPC pour les security groups"
  type        = string
}


variable "bastion_sg_id" {
  description = "ID du security group du bastion"
  type        = string
  #default     = null # Optionnel si vous n'avez pas toujours un bastion
}
