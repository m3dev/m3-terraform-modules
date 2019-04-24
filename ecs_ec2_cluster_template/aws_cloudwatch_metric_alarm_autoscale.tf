# TODO: https://dev.classmethod.jp/cloud/detect-ecs-service-throttling/ コンテナの状態変化回数のスパイクも監視する
# TODO: Cluster event を SNS (info) へ送る: https://aws.amazon.com/jp/blogs/news/monitor-cluster-state-with-amazon-ecs-event-stream/

resource "aws_cloudwatch_metric_alarm" "main_cpu_high" {
  alarm_name = "autoscaling-${var.application_name}-ecs-instance-cpu-high"

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"
  statistic   = "Average"

  evaluation_periods = "1"
  period             = "60"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = "${var.autoscaling_cpu_threshold_high}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.main.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.main_add_instance.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "main_cpu_low" {
  alarm_name = "autoscaling-${var.application_name}-ecs-instance-cpu-low"

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"
  statistic   = "Average"

  evaluation_periods = "1"
  period             = "300"

  comparison_operator = "LessThanThreshold"
  threshold           = "${var.autoscaling_cpu_threshold_low}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.main.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.main_remove_instance.arn}"]
}
