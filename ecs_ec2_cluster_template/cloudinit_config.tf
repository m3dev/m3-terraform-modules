data "cloudinit_config" "main" {
  # https://github.com/hashicorp/terraform/issues/11488
  # https://github.com/terraform-providers/terraform-provider-aws/issues/497
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/cloud-init.sh", {ecs_cluster_id = var.ecs_cluster_id})
  }
}

