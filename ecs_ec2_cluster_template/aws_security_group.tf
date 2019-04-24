
resource "aws_security_group" "main" {
  vpc_id = "${var.vpc_id}"

  name_prefix = "ecs-instance-${var.application_name}-"

  description = "ECS Instance EC2 of /applications/${var.application_name}"

  tags {
    Name = "/applications/${var.application_name}/ecs-instance"
  }
}

resource "aws_security_group_rule" "ingress_tcp_from_bastion" {
  count = "${length(var.maintenance_ingress_tcp_ports)}"

  security_group_id = "${aws_security_group.main.id}"
  type = "ingress"
  protocol = "tcp"
  from_port = "${element(split("-", element(var.maintenance_ingress_tcp_ports, count.index)), 0)}"
  to_port = "${element(split("-", element(var.maintenance_ingress_tcp_ports, count.index)), 1)}"
  source_security_group_id = "${var.maintenance_security_group_id}"
}

resource "aws_security_group_rule" "ingress_tcp_from_loadbalancer" {
  count = "${length(var.loadbalancer_ingress_tcp_ports)}"

  security_group_id = "${aws_security_group.main.id}"
  type = "ingress"
  protocol = "tcp"
  from_port = "${element(split("-", element(var.loadbalancer_ingress_tcp_ports, count.index)), 0)}"
  to_port = "${element(split("-", element(var.loadbalancer_ingress_tcp_ports, count.index)), 1)}"
  source_security_group_id = "${var.loadbalancer_security_group_id}"
}

resource "aws_security_group_rule" "egress_tcp_to_any" {
  count = "${length(var.egress_tcp_ports)}"

  security_group_id = "${aws_security_group.main.id}"
  type = "egress"
  protocol = "tcp"
  from_port = "${element(var.egress_tcp_ports, count.index)}"
  to_port = "${element(var.egress_tcp_ports, count.index)}"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
}