resource "aws_acm_certificate_validation" "cert" {
  count = "${var.acm_certificate_validation ? 1 : 0}"

  certificate_arn = aws_acm_certificate.https-certificate.arn
  validation_record_fqdns = [
    aws_route53_record.https-certificate-validation.fqdn,
  ]
}

