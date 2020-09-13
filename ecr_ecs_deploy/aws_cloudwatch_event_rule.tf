resource "aws_cloudwatch_event_rule" "ecr_deploy" {
  name_prefix = "${var.name_prefix}ecr-put-image"
  description = "ECR PutImage"

  event_pattern = jsonencode({
    source = [
      "aws.ecr"
    ]
    "detail" = {
      eventName = [
        "PutImage"
      ]
      "requestParameters": {
        "repositoryName": [
          var.ecr_repository_name
        ],
        "imageTag": [
          var.docker_image_tags
        ]
      }
    }
  })
}

resource "aws_cloudwatch_event_target" "slack" {
  rule = aws_cloudwatch_event_rule.ecr_deploy.name
  arn = aws_lambda_function.update_ecs_service.arn
}
