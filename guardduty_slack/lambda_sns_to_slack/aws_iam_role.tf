resource "aws_iam_role" "lambda_role" {
  count = var.guardduty_slack_webhook_url == "" ? 0 : 1
  name = var.basename

  assume_role_policy = data.aws_iam_policy_document.lambda_edge_assume_role[0].json
  tags = var.tags
}

data "aws_iam_policy_document" "lambda_edge_assume_role" {
  count = var.guardduty_slack_webhook_url == "" ? 0 : 1

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "viewer_request_lambda_execution" {
  count = var.guardduty_slack_webhook_url == "" ? 0 : 1

  role       = aws_iam_role.lambda_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "viewer_request_cloudwatch_logs" {
  count = var.guardduty_slack_webhook_url == "" ? 0 : 1

  role       = aws_iam_role.lambda_role[0].name
  policy_arn = aws_iam_policy.lambda_cloudwatch_logs[0].arn
}

resource "aws_iam_policy" "lambda_cloudwatch_logs" {
  count = var.guardduty_slack_webhook_url == "" ? 0 : 1

  name        = "${var.basename}-logs"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}
