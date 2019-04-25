resource "aws_security_group_rule" "loadbalancer-ingress-http" {
  security_group_id = aws_security_group.loadbalancer.id
  type              = "ingress"

  protocol    = "tcp"
  from_port   = var.http_port
  to_port     = var.http_port
  cidr_blocks = var.ingress_cidr_blocks

  description = "ingress_cidr_blocks"
}

resource "aws_security_group_rule" "loadbalancer-ingress-https" {
  security_group_id = aws_security_group.loadbalancer.id
  type              = "ingress"

  protocol    = "tcp"
  from_port   = var.https_port
  to_port     = var.https_port
  cidr_blocks = var.ingress_cidr_blocks

  description = "ingress_cidr_blocks"
}

resource "aws_security_group_rule" "loadbalancer-egress-target-subnet" {
  security_group_id = aws_security_group.loadbalancer.id
  type              = "egress"

  protocol    = "tcp"
  from_port   = "0"
  to_port     = "65535"
  cidr_blocks = var.target_subnet_cidr_blocks

  description = "target_subnet_cidr_blocks"
}

