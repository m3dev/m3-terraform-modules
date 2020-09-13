variable "ecr_repository_name" {
  type = string
  description = "Name of ECR repository to watch."
}

variable "ecs_cluster_name" {
  type = string
  description = "Name of ECS cluster which the ECS service belongs to"
}

variable "ecs_service_name" {
  type = string
  description = "Arn of ECS service to update"
}

variable "docker_image_tags" {
  type = string
  description = "Docker image tag to watch."
  default = "latest"
}

variable "name_prefix" {
  type = string
  description = "Prefix which is added for some resources."
  default = ""
}

