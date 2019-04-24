resource "aws_route53_record" "record" {
  zone_id = "${var.domain_zone_id}"
  type = "A"
  name = "${var.domain_name}"

  alias {
    evaluate_target_health = false
    name = "${data.aws_lb.main.dns_name}"
    zone_id = "${data.aws_lb.main.zone_id}"
  }
}
