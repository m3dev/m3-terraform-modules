resource "aws_ecr_repository" "main" {
  name = var.repository_name
  tags = var.repository_tags
}

