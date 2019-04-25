resource "aws_launch_template" "main" {
  name = "ecs-${var.application_name}-${var.envname}"

  image_id = "${local.image_id}"
  instance_type = "${var.ec2_instance_type}"

  key_name = "${var.ec2_ssh_keyname}"

  vpc_security_group_ids = [
    "${concat(list(aws_security_group.main.id), var.additional_security_groups)}"
  ]

  user_data = "${data.template_cloudinit_config.main.rendered}"

  monitoring {
    enabled = "${var.ec2_enable_monitoring}"
  }

  iam_instance_profile {
    name = "${aws_iam_instance_profile.ecs_instance_profile.name}"
  }

  block_device_mappings {
    device_name = "/dev/xvdcz"
    ebs {
      volume_type = "gp2"
      volume_size = "${var.ec2_volume_size}"
    }
  }
}
