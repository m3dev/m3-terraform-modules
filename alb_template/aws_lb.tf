resource "aws_lb" "main" {
  name               = replace(var.domain_name, ".", "-")
  internal           = false
  load_balancer_type = "application"

  subnets = var.subnet_ids
  security_groups = [
    aws_security_group.loadbalancer.id,
  ]

  enable_deletion_protection = true

  enable_http2    = true
  idle_timeout    = var.idle_timeout
  ip_address_type = "ipv4"

  access_logs {
    enabled = true
    bucket  = var.access_logs_bucket
    prefix  = var.domain_name
  }

  tags = {
    Name = var.domain_name
  }
}

