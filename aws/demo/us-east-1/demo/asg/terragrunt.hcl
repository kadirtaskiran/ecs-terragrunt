locals {
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  env              = local.environment_vars.locals.environment
  name             = local.environment_vars.locals.name
  account_name     = local.account_vars.locals.account_name
  region           = local.region_vars.locals.aws_region
  tags = {
    Owner       = "kadir.taskiran"
    Environment = "demo"
    Cluster     = "counter-app-cluster"
  }
  user_data = <<-EOT
  #!/bin/bash
  cat <<'EOF' >> /etc/ecs/ecs.config
  ECS_CLUSTER=counter-app-cluster
  ECS_CONTAINER_INSTANCE_TAGS={"Owner": "kadir.taskiran", "Environment": "demo"}
  EOF
  EOT

}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-autoscaling.git//?ref=v6.5.0"
}

include {
  path = find_in_parent_folders()
}

dependency "iam" {
  config_path = "../iam"
}

dependency "sg" {
  config_path = "../ec2-sg"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "alb" {
  config_path = "../alb"
}

inputs = {
  name                      = "${local.name}-asg"
  launch_template_name      = "${local.name}-${local.env}"
  create_launch_template    = true
  image_id                  = "ami-04ca8c64160cd4188"
  instance_type             = "t2.micro"
  security_groups           = [dependency.sg.outputs.security_group_id]
  iam_instance_profile_arn  = dependency.iam.outputs.iam_instance_profile_arn
  vpc_zone_identifier       = dependency.vpc.outputs.private_subnets
  health_check_type         = "EC2"
  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  tags                      = local.tags
  target_group_arns         = dependency.alb.outputs.target_group_arns
  user_data                 = base64encode(local.user_data)
  key_name                  = "kmt-key"

  scaling_policies = {
    request-count-per-target = {
      policy_type               = "TargetTrackingScaling"
      estimated_instance_warmup = 120
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ALBRequestCountPerTarget"
          resource_label         = join("/", [dependency.alb.outputs.lb_arn_suffix, dependency.alb.outputs.target_group_arn_suffixes[0]])
        }
        target_value = 20
      }
    }
  }


}

