resource "aws_acm_certificate" "https-certificate" {
  domain_name = "${var.domain_name}"
  subject_alternative_names = [ "${var.acm_certificate_alternative_names}" ]
  validation_method = "DNS"
}
