resource "aws_ecs_capacity_provider" "capacity_provider" {
  name = var.provider_name

  auto_scaling_group_provider {
    auto_scaling_group_arn = var.asg_arn
  }

  tags = var.tags
}

resource "aws_ecs_cluster_capacity_providers" "cluster_providers" {
  cluster_name = var.cluster_name

  capacity_providers = [aws_ecs_capacity_provider.capacity_provider.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.capacity_provider.name
  }

}

resource "aws_ecs_cluster" "ecs" {
  name = var.cluster_name
  tags = var.tags

  dynamic "setting" {
    for_each = var.settings
    content {
      name  = lookup(setting.value, "name", null)
      value = lookup(setting.value, "value", null)
    }
  }

  dynamic "setting" {
    for_each = var.enable_container_insights ? [1] : []
    content {
      name  = "containerInsights"
      value = "enabled"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}