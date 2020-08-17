resource "aws_cloudwatch_event_target" "guardduty_event_notify_to_sns" {
  provider = aws.regional

  target_id = "GuardDutyNotifyToSNS"
  rule      = aws_cloudwatch_event_rule.guardduty_event_notify.name
  arn       = aws_sns_topic.notify.arn
}
