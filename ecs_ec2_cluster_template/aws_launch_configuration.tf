resource "aws_launch_configuration" "main" {
  name_prefix = "ecs-${var.application_name}-${var.envname}-"

  image_id      = "${local.image_id}"
  instance_type = "${var.ec2_instance_type}"

  key_name                    = "${var.ec2_ssh_keyname}"

  enable_monitoring = "${var.ec2_enable_monitoring}"

  iam_instance_profile = "${aws_iam_instance_profile.ecs_instance_profile.name}"
  security_groups = [
    "${concat(list(aws_security_group.main.id), var.additional_security_groups)}"
  ]

  user_data = "${data.template_cloudinit_config.main.rendered}"

  ebs_block_device {
    device_name = "/dev/xvdcz"
    volume_type = "gp2"
    volume_size = "${var.ec2_volume_size}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
