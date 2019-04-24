resource "aws_route53_record" "https-certificate-validation" {
  name = "${aws_acm_certificate.https-certificate.domain_validation_options.0.resource_record_name}"
  type = "${aws_acm_certificate.https-certificate.domain_validation_options.0.resource_record_type}"
  zone_id = "${var.route53_zone_id}"
  records = [
    "${aws_acm_certificate.https-certificate.domain_validation_options.0.resource_record_value}"
  ]
  ttl = 60
}
