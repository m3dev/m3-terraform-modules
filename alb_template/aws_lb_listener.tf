resource "aws_lb_listener" "https" {
  load_balancer_arn = "${aws_lb.main.arn}"

  protocol = "HTTPS"
  port = 443
  certificate_arn = "${aws_acm_certificate.https-certificate.arn}"

  default_action {
    target_group_arn = "${aws_lb_target_group.default-target-group.arn}"
    type = "forward"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = "${aws_lb.main.arn}"

  protocol = "HTTP"
  port = 80

  default_action {
    target_group_arn = "${aws_lb_target_group.default-target-group.arn}"
    type = "forward"
  }
}
