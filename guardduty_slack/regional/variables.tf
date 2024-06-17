variable "envname" {}

variable "aws_region" {}

variable "enable" {}

variable "lambda_notify_to_slack_arn" {}

variable "is_enable_lambda_notify_to_slack" {
  type = bool
}

variable "is_enable_guardduty_ipset" {
  type = bool
}

variable "ipset_location" {}

variable "guardduty_finding_publishing_frequency" {}

variable "tags" {}

