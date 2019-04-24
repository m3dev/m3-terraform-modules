# AWS ALB template

Create ALB + SSL certificate.

This module also setup [DNS record](aws_route53_record.tf) and [aws_acm_certificate_validation](aws_acm_certificate_validation.tf) with DNS validation. So that this module requires Route53 hosted zone.

## Prerequisite

- You need to create Route53 hosted zone.
  - And the hosted zone should be properly delegated from the parent domain.
- You need to create S3 bucket to store access logs.
