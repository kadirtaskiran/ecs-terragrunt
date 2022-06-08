variable "cluster_name" {
  description = "Name of provider ECS cluster"
  type        = string
  default     = null
}

variable "provider_name" {
  description = "Name of provider"
  type        = string
  default     = null
}

variable "asg_arn" {
  description = "ARN of provider ASG"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
  default     = {}
}

variable "settings" {
  description = "List of maps with cluster settings. For example, this can be used to enable CloudWatch Container Insights for a cluster. [Terraform Docs](https://www.terraform.io/docs/providers/aws/r/ecs_cluster.html#setting)"
  default     = []
  type        = list(any)
}

variable "enable_container_insights" {
  description = "Enable container insights."
  default     = false
  type        = bool
}
