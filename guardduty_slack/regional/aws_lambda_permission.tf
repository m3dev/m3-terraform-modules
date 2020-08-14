resource "aws_lambda_permission" "notify" {
  count = var.is_enable_lambda_notify_to_slack == true ? 1 : 0

  # This object should be in main region, not regional
  statement_id = "guardduty_notify_${var.aws_region}"
  action        = "lambda:InvokeFunction"
  function_name = element(split(":", var.lambda_notify_to_slack_arn), length(split(":", var.lambda_notify_to_slack_arn)) - 1)
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.notify.arn
}
