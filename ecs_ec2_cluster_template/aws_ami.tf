locals {
  image_id = "${var.ec2_image_id == "" ? data.aws_ami.ecs-optimized.id : var.ec2_image_id}"
}

data "aws_ami" "ecs-optimized" {
  most_recent = true
  filter {
    name   = "name"
    values = ["*-amazon-ecs-optimized"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["591542846629"] # AWS
}
