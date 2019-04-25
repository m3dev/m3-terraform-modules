data "aws_lb_listener" "main" {
  arn = element(var.loadbalancer_listener_arns, 0)
}

data "aws_lb" "main" {
  arn = data.aws_lb_listener.main.load_balancer_arn
}

