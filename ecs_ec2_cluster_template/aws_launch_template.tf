resource "aws_launch_template" "main" {
  name = "ecs-${var.application_name}-${var.envname}"

  image_id      = local.image_id
  instance_type = var.ec2_instance_type

  key_name = var.ec2_ssh_keyname

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  vpc_security_group_ids = concat([aws_security_group.main.id], var.additional_security_groups)

  user_data = data.cloudinit_config.main.rendered

  monitoring {
    enabled = var.ec2_enable_monitoring
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  block_device_mappings {
    device_name = "/dev/xvdcz"
    ebs {
      volume_type = "gp2"
      volume_size = var.ec2_volume_size
    }
  }
}

