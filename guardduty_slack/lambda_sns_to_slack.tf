module "lambda_sns_to_slack" {
  source = "./lambda_sns_to_slack"

  basename = "guardduty-sns-to-slack-${var.envname}"
  guardduty_slack_webhook_url = var.guardduty_slack_webhook_url
  tags = var.tags
}
