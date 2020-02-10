# guardduty_slack

Notification of GuardDuty for Slack.

This module setups:

- AWS GuardDuty
- S3 bucket to store "trusted IP address" list
  - GuardDuty won't raise alert for trusted IPs.
- Slack notification (AWS lambda)

## Prerequisite

1. Create slack channel to notify
2. Issue slack webhook URL to post notification

## Variables

See [variables.tf](variables.tf) for parameters.
