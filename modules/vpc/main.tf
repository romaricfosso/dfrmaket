module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = var.vpc-name
  cidr = var.cidr-vpc
  azs  = var.azs

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway     = true
  one_nat_gateway_per_az = true
  single_nat_gateway     = false
  enable_dns_support     = true
  enable_dns_hostnames   = true

  enable_dhcp_options              = true
  dhcp_options_domain_name         = var.dhcp_name
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  tags = var.tags

  public_subnet_tags = {
    Name = "dfrmaket-public-subnet"
    Tier = "public"
  }

  private_subnet_tags = {
    Name = "dfrmaket-private-subnet"
    Tier = "private"
  }

  igw_tags = {
    Name = "dfrmaket-igw"
  }

  nat_gateway_tags = {
    Name = "dfrmaket-nat-gw"
  }

  dhcp_options_tags = {
    Name = "dfrmaket-dhcp-options"
  }

}
