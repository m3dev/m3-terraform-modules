resource "aws_alb_listener_rule" "main" {
  count = "${var.loadbalancer_listener_arns_count}"

  listener_arn = "${element(var.loadbalancer_listener_arns, count.index)}"

  priority = 1000

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.main.arn}"
  }
  condition {
    field = "host-header"
    values = [
      "${local.full_domain_name}"
    ]
  }
}


