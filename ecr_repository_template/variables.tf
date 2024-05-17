variable "repository_name" {
  description = "Name of the ECR repository"
}

variable "repository_tags" {
  description = "Tags of the ECR repository"
  type        = map(string)
  default     = {}
}

variable "image_tag_mutability" {
  description = "(Optional)The image tag mutability setting for the ECR repository"
  type        = string
  default     = "MUTABLE"
}

variable "untagged_images_expire_days" {
  default     = 14
  description = "Automatically delete untagged images (days after push)"
}

variable "image_scan_on_push" {
  description = "(Optional)Indicates whether images are scanned after being pushed to the repository"
  type        = bool
  default     = true
}
