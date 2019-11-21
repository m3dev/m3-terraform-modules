variable "envname" {}

variable "enable" {
  default = "true"
}

variable "s3_bucket_name" {
  description = "S3 bucket name to store GuardDuty settings (e.g. trusted IP list)"
}

variable "trusted_ip_cidr_blocks" {
  type        = list(string)
  description = "CIDR block notations of trusted IP address ranges"
  default     = []
}

variable "guardduty_slack_webhook_url" {
  description = "Slack webhook URL to post notification. Basically use same URL for all environments because no reason to separate security issue notification."
}
