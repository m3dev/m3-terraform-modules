resource "aws_lb_target_group" "default-target-group" {
  protocol = "HTTP"
  port     = var.default_target_group_port
  vpc_id   = var.vpc_id
}

