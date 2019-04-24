variable "repository_name" {
  description = "Name of the ECR repository"
}

variable "untagged_images_expire_days" {
  default = 14
  description = "Automatically delete untagged images (days after push)"
}