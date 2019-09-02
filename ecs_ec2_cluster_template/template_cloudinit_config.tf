data "template_cloudinit_config" "main" {
  # https://github.com/hashicorp/terraform/issues/11488
  # https://github.com/terraform-providers/terraform-provider-aws/issues/497
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.cloud_init_script.rendered
  }
}

data "template_file" "cloud_init_script" {
  template = file("${path.module}/cloud-init.sh")

  vars = {
    ecs_cluster_id = var.ecs_cluster_id
  }
}

