resource "aws_cloudwatch_metric_alarm" "lambda_error" {
  alarm_name        = "${var.function_name}-errors"
  alarm_description = "Lambda \"${var.function_name}\" error occured"

  namespace          = "AWS/Lambda"
  metric_name        = "Errors"
  statistic          = "Maximum"
  period             = "60"
  evaluation_periods = "1"

  treat_missing_data = "notBreaching"

  comparison_operator = "GreaterThanThreshold"
  threshold           = "0"

  dimensions = {
    FunctionName = var.function_name
  }

  alarm_actions = [var.sns_arn]
}

resource "aws_cloudwatch_metric_alarm" "lambda_throttles" {
  alarm_name        = "${var.function_name}-throttles"
  alarm_description = "Lambda \"${var.function_name}\" throttled"

  namespace          = "AWS/Lambda"
  metric_name        = "Throttles"
  statistic          = "Maximum"
  period             = "60"
  evaluation_periods = "1"

  treat_missing_data = "notBreaching"

  comparison_operator = "GreaterThanThreshold"
  threshold           = "0"

  dimensions = {
    FunctionName = var.function_name
  }

  alarm_actions = [var.sns_arn]
}


resource "aws_cloudwatch_metric_alarm" "lambda_duration" {
  count = (var.duration_alarm_ms == 0) ? 0 : 1

  alarm_name        = "${var.function_name}-duration"
  alarm_description = "Lambda \"${var.function_name}\" duration too long"

  namespace          = "AWS/Lambda"
  metric_name        = "Duration"
  statistic          = "Maximum"
  period             = "60"
  evaluation_periods = "1"

  treat_missing_data = "notBreaching"

  comparison_operator = "GreaterThanThreshold"
  threshold           = var.duration_alarm_ms

  dimensions = {
    FunctionName = var.function_name
  }

  alarm_actions = [var.sns_arn]
}

resource "aws_cloudwatch_metric_alarm" "lambda_invocations_max" {
  alarm_name        = "${var.function_name}-invocations-max"
  alarm_description = "Lambda \"${var.function_name}\" too many invocations"

  namespace          = "AWS/Lambda"
  metric_name        = "Invocations"
  statistic          = "Sum"
  period             = var.invocations_window_seconds
  evaluation_periods = "1"

  treat_missing_data = "notBreaching"

  comparison_operator = "GreaterThanThreshold"
  threshold           = var.invocations_max

  dimensions = {
    FunctionName = var.function_name
  }

  alarm_actions = [var.sns_arn]
}

resource "aws_cloudwatch_metric_alarm" "lambda_invocations_min" {
  alarm_name        = "${var.function_name}-invocations-min"
  alarm_description = "Lambda \"${var.function_name}\" too few invocations"

  namespace          = "AWS/Lambda"
  metric_name        = "Invocations"
  statistic          = "Sum"
  period             = var.invocations_window_seconds
  evaluation_periods = "1"

  treat_missing_data = "notBreaching"

  comparison_operator = "LessThanThreshold"
  threshold           = var.invocations_min

  dimensions = {
    FunctionName = var.function_name
  }

  alarm_actions = [var.sns_arn]
}
