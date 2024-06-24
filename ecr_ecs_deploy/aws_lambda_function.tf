resource "random_id" "suffix" {
  byte_length = 8
}

data "aws_ecs_cluster" "cluster" {
  cluster_name = var.ecs_cluster_name
}

data "aws_ecs_service" "service" {
  cluster_arn = data.aws_ecs_cluster.cluster.arn
  service_name = var.ecs_service_name
}

resource "aws_lambda_function" "update_ecs_service" {
  filename = data.archive_file.lambda.output_path
  function_name = "${var.name_prefix}-update_ecs_service-${random_id.suffix.hex}"
  role = aws_iam_role.lambda_execution.arn
  handler = "main.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime = "python3.8"
  memory_size = 128
  timeout = 30

  environment {
    variables = {
      "EcsServiceArn" = data.aws_ecs_service.service.arn
      "EcsClusterName" = var.ecs_cluster_name
    }
  }

  lifecycle {
    ignore_changes = [
      filename,
    ]
  }
}

data "archive_file" "lambda" {
  type = "zip"
  source_dir = "${abspath(path.module)}/lambda"
  output_path = "${abspath(path.module)}/.upload/slack.zip"
}
