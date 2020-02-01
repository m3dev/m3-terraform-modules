variable "function_name" {
  description = "Name of Lambda to monitor (function_name attribute of aws_lambda_function)"
}
variable "sns_arn" {
  description = "ARN of SNS topic to notify alarm (arn attribute of aws_sns_topic)."
}

variable "duration_alarm_ms" {
  default = 0
  description = "Milliseconds threshold to alarm too long lambda execution. 0 (default) to disable this alarm."
}
