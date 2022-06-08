locals {
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  env              = local.environment_vars.locals.environment
  account_name     = local.account_vars.locals.account_name
  region           = local.region_vars.locals.aws_region
  vpc_cidr_prefix  = "10.10"
  tags = {
    Owner       = "kadir.taskiran"
    Environment = "demo"
  }

}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git//?ref=v3.14.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                 = local.account_name
  cidr                 = "${local.vpc_cidr_prefix}.0.0/16"
  azs                  = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets      = ["${local.vpc_cidr_prefix}.11.0/24", "${local.vpc_cidr_prefix}.12.0/24", "${local.vpc_cidr_prefix}.13.0/24"]
  public_subnets       = ["${local.vpc_cidr_prefix}.1.0/24", "${local.vpc_cidr_prefix}.2.0/24", "${local.vpc_cidr_prefix}.3.0/24"]
  enable_vpn_gateway   = false
  enable_ipv6          = false
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = local.tags
  vpc_tags = {
    Name = local.account_name
  }
}

