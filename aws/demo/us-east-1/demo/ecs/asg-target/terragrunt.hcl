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
  source = "git::https://github.com/HENNGE/terraform-aws-ecs.git//modules/core/ecs-autoscaling-target?ref=2.1.0"
}

include {
  path = find_in_parent_folders()
}

dependency "cluster" {
  config_path = "../cluster"
}

dependency "service" {
  config_path = "../service"
}

inputs = {
  ecs_cluster_name = dependency.cluster.outputs.ecs_cluster_name
  ecs_service_name = dependency.service.outputs.name
  min_capacity     = 1
  max_capacity     = 2
}

