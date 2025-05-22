variable "ami_id" {
  type        = string
  description = "ID de l'AMI à utiliser pour l'instance WordPress"
}

variable "instance_type" {
  type        = string
  description = "Type d'instance EC2 à lancer (ex: t3.micro)"
}

variable "key_name" {
  type        = string
  description = "Nom de la paire de clés SSH pour accéder à l'instance"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Liste des subnets disponibles (on utilisera le premier)"
}

variable "vpc_id" {
  type        = string
  description = "ID de la VPC dans laquelle déployer l'EC2"
}

variable "sg_ec2_id" {
  type        = string
  description = "ID du Security Group à attacher à l'instance"
}

variable "iam_instance_role_name" {
  type        = string
  description = "Nom du rôle IAM attaché à l'instance (ex: pour Secrets Manager)"
}

variable "user_data_path" {
  type        = string
  description = "Chemin vers le script user_data WordPress"
}

variable "tags" {
  type        = map(string)
  description = "Tags communs à appliquer aux ressources"
}
variable "alb_target_group_arn" {
  type        = string
  description = "ARN du Target Group ALB pour attacher l'ASG"
}


variable "db_host" {
  type        = string
  description = "Adresse du endpoint RDS pour WordPress"
}
variable "db_name" {
  type        = string
  description = "Nom de la base de données pour WordPress"
}

variable "db_user" {
  type        = string
  description = "Nom d'utilisateur pour WordPress"
}
variable "db_password" {
  type        = string
  description = "Mot de passe pour WordPress"
}
