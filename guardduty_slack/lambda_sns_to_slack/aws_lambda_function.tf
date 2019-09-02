output "lambda_arn" {
  value = "${aws_lambda_function.lambda.arn}"
}

resource "aws_lambda_function" "lambda" {
  publish       = true
  function_name = "${var.basename}"

  filename         = "${substr(data.archive_file.lambda.output_path, length(path.cwd) + 1, -1)}"
  handler          = "index.lambda_hander"
  source_code_hash = "${data.archive_file.lambda.output_base64sha256}"

  role = "${aws_iam_role.lambda_role.arn}"

  runtime     = "python3.6"
  memory_size = 128
  timeout     = 30

  environment {
    variables = {
      slack = "${var.guardduty_slack_webhook_url}"
    }
  }

  lifecycle {
    ignore_changes = ["last_modified"]
  }
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/temp/${var.basename}-dist.zip"
}
