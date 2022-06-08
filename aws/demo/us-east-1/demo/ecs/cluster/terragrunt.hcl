locals {
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  env              = local.environment_vars.locals.environment
  app_name         = local.environment_vars.locals.name
  account_name     = local.account_vars.locals.account_name
  region           = local.region_vars.locals.aws_region
  tags = {
    Owner       = "kadir.taskiran"
    Environment = "demo"
  }

}

terraform {
  source = "./terraform"
}

include {
  path = find_in_parent_folders()
}

dependency "asg" {
  config_path = "../../asg"
}

inputs = {
  cluster_name  = "${local.app_name}-cluster"
  provider_name = "${local.app_name}-pvdr"
  tags          = local.tags
  asg_arn       = dependency.asg.outputs.autoscaling_group_arn
}

