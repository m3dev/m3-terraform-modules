resource "aws_security_group" "container" {
  name_prefix = "${var.envname}-${var.application_name}-containers"
  vpc_id      = var.vpc_id

  description = "ECS Service of /applications/${var.application_name}"

  tags = {
    Name = "/applications/${var.application_name}/ecs-service"
  }
}

resource "aws_security_group_rule" "container_egress_tcp_ports_to_any" {
  count = length(var.egress_tcp_ports)

  type              = "egress"
  security_group_id = aws_security_group.container.id

  protocol  = "tcp"
  from_port = element(var.egress_tcp_ports, count.index)
  to_port   = element(var.egress_tcp_ports, count.index)
  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group_rule" "container_ingress_container_port_from_lb" {
  type              = "ingress"
  security_group_id = aws_security_group.container.id

  protocol                 = "tcp"
  from_port                = var.target_container_port
  to_port                  = var.target_container_port
  source_security_group_id = var.loadbalancer_security_group_id
}

resource "aws_security_group_rule" "container_ingress_container_port_from_maintenance" {
  type              = "ingress"
  security_group_id = aws_security_group.container.id

  protocol                 = "tcp"
  from_port                = var.target_container_port
  to_port                  = var.target_container_port
  source_security_group_id = var.maintenance_security_group_id
}

resource "aws_security_group_rule" "container_ingress_tcp_ports_from_maintenance" {
  count = length(var.maintenance_ingress_tcp_ports)

  type              = "ingress"
  security_group_id = aws_security_group.container.id

  protocol                 = "tcp"
  from_port                = element(var.maintenance_ingress_tcp_ports, count.index)
  to_port                  = element(var.maintenance_ingress_tcp_ports, count.index)
  source_security_group_id = var.maintenance_security_group_id
}

