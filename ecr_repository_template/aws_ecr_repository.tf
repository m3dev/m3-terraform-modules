resource "aws_ecr_repository" "main" {
  name                 = var.repository_name
  tags                 = var.repository_tags
  image_tag_mutability = var.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = var.image_scan_on_push
  }
}

