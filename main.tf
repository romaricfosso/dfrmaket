module "vpc" {
  source   = "./modules/vpc"
  vpc-name = var.vpc-name

  cidr-vpc        = var.cidr-vpc
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  dhcp_name       = var.dhcp_name
  tags            = var.tags



}
module "kms" {
  source      = "./modules/kms"
  alias_name  = var.alias_name
  description = var.description
  tags        = var.tags
}
module "security_groups" {
  source        = "./modules/security_groups"
  vpc_id        = module.vpc.vpc_id
  sg_alb        = var.sg_alb
  sg_ec2        = var.sg_ec2
  sg_rds        = var.sg_rds
  bastion_sg_id = module.bastion.sg_id
  tags          = var.tags
}
module "secrets" {
  source      = "./modules/secrets_manager"
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  db_host     = module.rds.db_host # Overwritten in runtime
  tags        = var.tags
}

module "rds" {
  source             = "./modules/rds"
  private_subnet_ids = module.vpc.private_subnets
  vpc_id             = module.vpc.vpc_id
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  kms_key_id         = module.kms.key_arn
  sg_rds_id          = module.security_groups.sg_rds_id
  tags               = var.tags
}
module "iam_secrets_role" {
  source    = "./modules/iam_secrets_role"
  role_name = var.role_name
  tags      = var.tags
}
module "alb" {
  source                      = "./modules/alb"
  vpc_id                      = module.vpc.vpc_id
  subnet_ids                  = module.vpc.public_subnets
  sg_alb_id                   = module.security_groups.sg_alb_id
  deletion_protection_enabled = var.deletion_protection_enabled
  #certificate_arn = var.certificate_arn
  domain_name = var.domain_name
  depends_on  = [module.vpc]

  tags = var.tags
}
module "keypair" {
  source       = "./modules/keypair"
  key_name     = var.key_name
  generate_key = true
  tags         = var.tags
}
module "ec2" {
  source                 = "./modules/ec2"
  ami_id                 = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_ids             = module.vpc.private_subnets
  vpc_id                 = module.vpc.vpc_id
  sg_ec2_id              = module.security_groups.sg_ec2_id
  iam_instance_role_name = module.iam_secrets_role.name
  user_data_path         = var.user_data_path
  alb_target_group_arn   = module.alb.target_group_arn
  tags                   = var.tags
  db_name                = var.db_name
  db_password            = var.db_password
  db_host                = module.rds.db_host
  db_user                = var.db_username
  depends_on             = [module.vpc]
}
module "bastion" {
  source    = "./modules/bastion"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]
  key_name  = var.key_name
  tags      = var.tags
}

resource "aws_route53_record" "acm_dns_validation" {
  zone_id = data.aws_route53_zone.dfr_itech.zone_id

  name    = "_lslner7u87w6ikqedurjxjbhkc45mhx.dfr-itech.com"
  type    = "CNAME"
  ttl     = 300
  records = ["dfr-itech.com_lslner7u87w6ikqedurjxjbhkc45mhx"]
}
resource "aws_route53_record" "site_wordpress" {
  zone_id = data.aws_route53_zone.dfr_itech.zone_id
  name    = "dfr-itech.com" # ou le nom de domaine souhaité
  type    = "A"

  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}
