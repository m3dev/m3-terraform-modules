resource "aws_sns_topic" "notify" {
  provider = aws.regional

  name = "mdl-guardduty-${var.envname}-notify"
  tags = var.tags
}

resource "aws_sns_topic_subscription" "lambda_to_slack" {
  count    = var.is_enable_lambda_notify_to_slack == true ? 1 : 0
  provider = aws.regional

  topic_arn = aws_sns_topic.notify.arn
  protocol  = "lambda"
  endpoint  = var.lambda_notify_to_slack_arn

  depends_on = [
    aws_sns_topic.notify,
  ]
}

resource "aws_sns_topic_policy" "notify" {
  provider = aws.regional
  arn      = aws_sns_topic.notify.arn
  policy   = data.template_file.sns_topic_policy_notify.rendered
}

data "template_file" "sns_topic_policy_notify" {
  template = data.aws_iam_policy_document.sns_topic_policy.json

  vars = {
    topic_arn = aws_sns_topic.notify.arn
  }
}
