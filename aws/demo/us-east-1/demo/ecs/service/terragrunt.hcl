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
  source = "git::https://github.com/HENNGE/terraform-aws-ecs.git//modules/simple/ec2?ref=2.1.0"
}

include {
  path = find_in_parent_folders()
}

dependency "cluster" {
  config_path = "../cluster"
}

dependency "alb" {
  config_path = "../../alb"
}

inputs = {
  name                         = "${local.app_name}-ec2"
  cluster                      = dependency.cluster.outputs.ecs_cluster_name
  cpu                          = 128
  memory                       = 128
  desired_count                = 1
  ignore_desired_count_changes = true

  target_group_arn = dependency.alb.outputs.target_group_arns[0]
  container_name = "${local.app_name}-cont"
  container_port = 80

  container_definitions = jsonencode([
    {
      name = "${local.app_name}-cont"
      image = "nginx:latest"
      cpu = 128
      memory = 128
      portMappings = [
        {
          containerPort = 80
          hostPort = 0
        }
      ]
    }])
  tags          = local.tags
}

