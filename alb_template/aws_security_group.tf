resource "aws_security_group" "loadbalancer" {
  name_prefix = "loadbalancer-${replace(var.domain_name, ".", "-")}"
  vpc_id      = var.vpc_id

  description = "LoadBalancer of ${var.domain_name}"

  tags = {
    Name = "ALB ${var.domain_name}"
  }
}

