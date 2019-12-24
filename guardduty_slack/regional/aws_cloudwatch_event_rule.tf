resource "aws_cloudwatch_event_rule" "guardduty_event_notify" {
  provider = aws.regional

  name = "guardduty-event-notify"
  description = "GuardDuty event"

  # High (the value of the severity parameter in the GetFindings response falls within the 7.0 to 8.9 range)
  # Medium (the value of the severity parameter in the GetFindings response falls within the 4.0 to 6.9 range)
  # Low (the value of the severity parameter in the GetFindings response falls within the 0.1 to 3.9 range)
  #
  # https://devops.stackexchange.com/a/3636
  event_pattern = <<EOF
{
  "source": [ "aws.guardduty" ],
  "detail-type": [ "GuardDuty Finding" ],
  "detail": {
    "severity": [
      4.0,4.1,4.2,4.3,4.4,4.5,4.6,4.7,4.8,4.9,5.0,5.1,5.2,5.3,5.4,5.5,5.6,5.7,5.8,5.9,6.0,6.1,6.2,6.3,6.4,6.5,6.6,6.7,6.8,6.9,
      7.0,7.1,7.2,7.3,7.4,7.5,7.6,7.7,7.8,7.9,8.0,8.1,8.2,8.3,8.4,8.5,8.6,8.7,8.8,8.9
    ]
  }
}
EOF
}
