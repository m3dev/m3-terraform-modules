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

variable "invocations_max" {
  description = "Threshold to alarm too many invocations."
}

variable "invocations_min" {
  description = "Threshold to alarm too many invocations."
}

variable "invocations_window_seconds" {
  default = 5 * 60
  description = "Window (duration) to check max,min_invocations. Unit is [sec]."
}
