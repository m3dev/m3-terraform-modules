resource "aws_ecr_lifecycle_policy" "untagged" {
  repository = aws_ecr_repository.main.id
  policy     = <<EOF
{
    "rules": [
        {
            "rulePriority": 100,
            "description": "Expire untagged images since image pushed ${var.untagged_images_expire_days} days ago",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": ${var.untagged_images_expire_days}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF

}

