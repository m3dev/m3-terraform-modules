locals {
  ipset_location        = "https://s3-${data.aws_region.current.name}.amazonaws.com/${aws_s3_bucket_object.trusted_ipset.bucket}/${aws_s3_bucket_object.trusted_ipset.key}"
  trusted_ipset_content = join("\n", var.trusted_ip_cidr_blocks)
}

resource "aws_s3_bucket_object" "trusted_ipset" {
  acl    = "public-read"
  bucket = aws_s3_bucket.main.id
  key    = "ipset-${sha1(local.trusted_ipset_content)}"

  etag    = md5(local.trusted_ipset_content)
  content = local.trusted_ipset_content
}
