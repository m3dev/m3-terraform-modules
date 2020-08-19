output "lambda_arn" {
  value = var.guardduty_slack_webhook_url == "" ? null : aws_lambda_function.lambda[0].arn
}

resource "aws_lambda_function" "lambda" {
  count = var.guardduty_slack_webhook_url == "" ? 0 : 1

  publish       = true
  function_name = var.basename
  tags          = var.tags

  filename         = substr(data.archive_file.lambda[0].output_path, length(abspath(path.cwd)) + 1, -1)
  handler          = "index.lambda_hander"
  source_code_hash = data.archive_file.lambda[0].output_base64sha256

  role = aws_iam_role.lambda_role[0].arn

  runtime     = "python3.6"
  memory_size = 128
  timeout     = 30

  environment {
    variables = {
      slack = var.guardduty_slack_webhook_url
    }
  }

  lifecycle {
    ignore_changes = [last_modified]
  }
}

data "archive_file" "lambda" {
  count = var.guardduty_slack_webhook_url == "" ? 0 : 1

  type        = "zip"
  source_dir  = "${abspath(path.module)}/src"
  output_path = "${abspath(path.module)}/temp/${var.basename}-dist.zip"
}

