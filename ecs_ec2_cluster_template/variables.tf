variable "envname" {
  description = "Envrionment name (e.g. 'prod'), used as name prefix of some resources"
}

variable "application_name" {
  description = "Basename for resources such as AutoScalingGroup, IAM Policy, ..."
}

variable "ecs_cluster_id" {
  description = "Value of aws_ecs_cluster.id, you have to create aws_ecs_cluster by your own code."
}

variable "vpc_id" {
  description = "ID of the VPC."
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet ID to run EC2 instances within it. Those subnets must belong to VPC that indicated by vpc_id."
}

variable "additional_security_groups" {
  type        = list(string)
  default     = []
  description = "List of ID of SecurityGroup to attach on the EC2 instances. Note that this module automatically generate one SG in addition (output.container_security_group_id)."
}

variable "maintenance_security_group_id" {
  description = "SecurityGroup ID for the maintenance use (e.g. SG of the bastion server)."
}

variable "maintenance_ingress_tcp_ports" {
  type = list(string)

  default = [
    "22",
    "80",
    "443",
    "32768-65535",
  ]

  description = "TCP port list of access from maintenance_security_group_id. Can specify range with hypen (e.g. 32768-65535)"
}

variable "loadbalancer_security_group_id" {
  description = "Security Group of LoadBalancer. This module allow access from this SG."
}

variable "loadbalancer_ingress_tcp_ports" {
  type = list(string)

  default = [
    "80",
    "443",
    "32768-65535",
  ]

  description = "TCP port list of access from LoadBalancer. Can specify range with hypen (e.g. 32768-65535)"
}

variable "egress_tcp_ports" {
  type = list(string)

  default = [
    80,
    443,
  ]

  description = "TCP port list of access from ECS node (EC2 instance). Allow to any destination."
}

variable "ec2_image_id" {
  default     = ""
  description = "EC2 image ID. If empty (default), use AWS official ecs-optimized AMI"
}

variable "ec2_instance_type" {
  description = "EC2 Instance Type (e.g. 't2.micro')"
}

variable "ec2_volume_size" {
  description = "EC2 Instance data volume size (GB). Cannot be smaller than size of snapshot of AMI (currently 22 GB)."
}

variable "ec2_ssh_keyname" {
  default     = ""
  description = "SSH key to login to EC2 instance. Empty to disable SSH login."
}

variable "ec2_enable_monitoring" {
  default     = "true"
  description = "true to enable EC2 detailed monitoring. Recommend to enable in production."
}

variable "autoscaling_max" {
  description = "Max instances (count of EC2 instance) of AutoScaling"
}

variable "autoscalling_desired_capacity" {
  description = "Initial instances (count of EC2 instance) of AutoScaling"
}

variable "autoscaling_min" {
  description = "Minimum instances (count of EC2 instance) of AutoScaling"
}

variable "autoscaling_cpu_threshold_high" {
  default     = "50"
  description = "AutoScaling threshold of CPU usage to add more EC2 instance (percentage)"
}

variable "autoscaling_cpu_threshold_low" {
  default     = "5"
  description = "AutoScaling threshold of CPU usage to delete EC2 instance (percentage)"
}

variable "autoscaling_scaledown_between_utc" {
  type    = list(string)
  default = ["", ""]

  # Example: [ "0 13 * * *", "0 0 * * 1-5" ]
  #   - Reduce EC2 instances in 10PM (JST) everyday
  #   - Boot EC2 instances in 9AM (JST) of every weekdays
  description = <<EOF
If you specify two crontabs (begging & end), delete EC2 instances during the specified term. 
This module reduces AutoScaling instance count to zero (or to autoscaling_scaledown_* values, see below) at the begging of the term (1st crontab of this value).
Then restore AutoScaling settings at the end (2nd crontab of this value).
If each element of the list is empty string, do nothing.

This setting is useful to reduce cost of development environment because you can stop instances during midnight and weekends.
Also you can use this setting to reduce cost of production, but don't forget to change autoscaling_scaledown_* settings to keep some instances running.
Otherwise it makes instance count to zero by default.
EOF

}

variable "autoscaling_scaledown_max" {
  default     = 0
  description = "Max instance count during autoscaling_scaledown_between_utc period."
}

variable "autoscaling_scaledown_desired_capacity" {
  default     = 0
  description = "Instance count during autoscaling_scaledown_between_utc period."
}

variable "autoscaling_scaledown_min" {
  default     = 0
  description = "Minimum instance count during autoscaling_scaledown_between_utc period."
}

