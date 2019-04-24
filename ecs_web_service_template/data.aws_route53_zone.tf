locals {
  # note: ALB の rule などは末尾にドットが付くドメイン名表記が使えないので、末尾ドットは取り除く必要あり
  full_domain_name = "${var.domain_name}.${replace(data.aws_route53_zone.main.name, "/\\.$/", "")}"
}

data "aws_route53_zone" "main" {
  zone_id = "${var.domain_zone_id}"
}
