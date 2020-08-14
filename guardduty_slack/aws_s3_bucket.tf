resource "aws_s3_bucket" "main" {
  bucket_prefix = "${var.s3_bucket_name}-"
  tags          = var.tags

  acl = "private"
}
