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
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-alb.git//?ref=v6.10.0"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "alb-sg" {
  config_path = "../sg"
}

inputs = {
  name               = "${local.app_name}-alb"
  load_balancer_type = "application"
  vpc_id             = dependency.vpc.outputs.vpc_id
  security_groups    = [dependency.alb-sg.outputs.security_group_id]
  subnets            = dependency.vpc.outputs.public_subnets
  tags               = local.tags
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  target_groups = [
    {
      name             = "${local.app_name}-ec2"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  http_tcp_listener_rules = [
    {
      http_tcp_listener_index = 0
      actions = [{
        type         = "forward"
        target_groups = [
          {
            target_group_index = 0
            weight             = 1
          }
        ]
      }]
      conditions = [{
        path_patterns =  ["/ec2"]

      }]
    }
  ]

}

