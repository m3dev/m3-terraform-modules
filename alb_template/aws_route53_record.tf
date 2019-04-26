resource "aws_route53_record" "https-certificate-validations" {
  count = 1 + length(var.acm_certificate_alternative_names)

  name    = aws_acm_certificate.https-certificate.domain_validation_options[count.index].resource_record_name
  type    = aws_acm_certificate.https-certificate.domain_validation_options[count.index].resource_record_type
  zone_id = var.route53_zone_id
  records = [
    aws_acm_certificate.https-certificate.domain_validation_options[count.index].resource_record_value,
  ]
  ttl = 60
}
