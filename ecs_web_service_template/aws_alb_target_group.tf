resource "random_string" "aws_alb_target_group_name_suffix" {
  # https://github.com/terraform-providers/terraform-provider-aws/issues/636#issuecomment-388781304
  # 名前をランダムにしないと、recreate がうまくいかない

  length  = 2
  special = false
}

resource "aws_alb_target_group" "main" {
  vpc_id = var.vpc_id

  # name_prefix は 6 文字制限があり、厳しい...
  # name_prefix = "${var.envname}-${var.application_name}"
  name = "${var.envname}-${var.application_name}-${random_string.aws_alb_target_group_name_suffix.result}"

  target_type = var.target_type

  protocol = var.target_group_protocol

  # ECS の機能で LB 登録する際に個別に上書き指定されるので、ここの port 番号は意味なし
  port = "80"

  slow_start           = var.slow_start_sec
  deregistration_delay = var.deregistration_delay

  health_check {
    protocol = var.target_group_protocol
    path     = var.health_check_path
    matcher  = var.health_check_matcher

    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    unhealthy_threshold = var.unhealthy_threshold
    healthy_threshold   = var.healthy_threshold
  }

  tags = {
    Name = "${var.envname}-${var.application_name}"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }
}

