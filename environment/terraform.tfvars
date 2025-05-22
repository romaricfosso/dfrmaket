region = "eu-west-1"
# VPC
vpc-name = "dfrmaket-vpc"
cidr-vpc = "10.0.0.0/16"
azs      = ["eu-west-1a", "eu-west-1b"]

# Subnets publics et privés
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]

# DHCP
dhcp_name = "clouddream.internal"

# KMS
alias_name  = "dfrmaket-rds-key"
description = "Clé KMS pour chiffrement des données sensibles (RDS, S3...)"

# Tags communs
tags = {
  Project     = "clouddream"
  Environment = "production"
  Owner       = "infra-team"
}
#sercret manager 
db_name     = "dfritech"
db_username = "romaric"
db_password = "romaric789!" # Stocké de manière sécurisée
#db_host     = "dfritech-instance.cfmyaaeoczoc.eu-west-1.rds.amazonaws.com" # Sera remplacé dynamiquement plus tard
sg_ec2 = "dfrmaket-sg-ec2"
sg_rds = "dfrmaket-sg-rds"
sg_alb = "dfrmaket-sg-alb"
#ec2 
#ami_id        = "ami-0c55b159cbfafe1f0" # Exemple Amazon Linux 2 (région eu-west-1)
instance_type               = "t3.micro"
key_name                    = "dfritech"
deletion_protection_enabled = false
user_data_path              = "./modules/ec2/user_data/wordpress.sh"
role_name                   = "ec2-wordpress-secrets-role"

#alb
domain_name = "dfr-itech.com"
ssl_policy  = "ELBSecurityPolicy-2016-08"
# certificate_arn = "arn"
