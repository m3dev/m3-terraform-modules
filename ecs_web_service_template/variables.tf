variable "envname" {
  description = "Envrionment name (e.g. 'prod'), used as name prefix of some resources"
}

variable "application_name" {
  description = "Basename for resources such as ECS Cluster, and so on. Should be short string."
}

variable "ecs_cluster_id" {
  description = "Value of aws_ecs_cluster.id, you have to create aws_ecs_cluster by your own code."
}

variable "launch_type" {
  description = "'FARGATE' or 'EC2'. Note that this module don't create EC2 instances. Use ../ecs_ec2_cluster_template to setup EC2 + AutoScaling."
}

variable "network_mode" {
  description = "Fargate only supports 'awsvpc'. For EC2, recommend to use 'bridge'."
}

variable "target_type" {
  description = "For network_mode=awsvpc, only 'ip' is allowed. For 'bridge', recommend to use 'instance'."
}

variable "vpc_id" {
  description = "ID of the VPC to run this ECS service. Must be owner of subnets in 'subnet_ids' variable."
}

variable "subnet_ids" {
  type        = list(string)
  description = "ID of subnets to run ECS task."
}

variable "additional_security_groups" {
  type        = list(string)
  default     = []
  description = "List of ID of SecurityGroup to assign to ECS task. Note that this module automatically generate one SG in addition."
}

variable "egress_tcp_ports" {
  type = list(string)
  default = [
    80,
    443,
  ]
  description = "List of allowed egress ports from ECS task to any destination. If you want detailed configuration, create custom Security Group and specify it in 'additional_security_groups'."
}

variable "domain_zone_id" {
  description = "Route53 zone ID. This module automatically create DNS record that points this service. See 'domain_name' variable for detail."
}

variable "domain_name" {
  description = <<EOF
Sub-domain name under zone of the 'domain_zone_id'. 
For example, if you specify 'my-service' to this variable and the zone of domain_zone_id is a 'zone.example.com', this ECS service provides service in a 'my-service.zone.example.com' domain.
This module automatically creates Route53 DNS record and ALB rule to receive traffic to the domain.

Do not add trailing dot in this variable (OK: 'my-service', NG: 'my-service.').
EOF

}

variable "loadbalancer_listener_arns" {
  type = list(string)
  description = <<EOF
List of listener ARN of ALB. All listeners must belong to same ALB.

This module automatically add ALB listener rule to the listeners.
Listener rule checks 'Host: ' header

Because this variable accepts multiple listeners, you can recceive both HTTP and HTTPS traffic with one ECS service definition.
EOF

}

variable "loadbalancer_listener_arns_count" {
  description = "Length of loadbalancer_listener_arns. This variable is required with current terraform due to https://github.com/hashicorp/terraform/issues/12570#issuecomment-318414280 this restriction."
}

variable "loadbalancer_listener_priority" {
  default = 1000
  description = "The priority for the rule of the loadbalancer."
}

variable "loadbalancer_security_group_id" {
  description = "SecurityGroup of the loadbalancer to allow incoming traffic from it."
}

variable "maintenance_security_group_id" {
  description = "SecurityGroup ID of the maintenance server (e.g. bastion server). This module allow access from this SG."
}

variable "maintenance_ingress_tcp_ports" {
  type        = list(string)
  default     = []
  description = <<EOF
List of allowed TCP ports from maintenance_security_group to containers.
`target_container_port` are automatically added into this list, you do not need to specify it in here.
EOF

}

variable "policy_arn" {
  # Currently cannot use list due to "value of 'count' cannot be computed" issue.
  description = "ARN of IAM policy to attatch to the ECS task"
}

variable "task_execution_policy_arn" {
  default = ""
  description = "ARN of IAM policy to attatch to ESC task execution role"
}

variable "cpu" {
  # cpu/memory conbinations in Fargate: https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/AWS_Fargate.html
  description = "CPU resources to ECS task (includes all containers in the task). Actual vCPU core is cpu/1024."
}

variable "memory_mb" {
  # cpu/memory conbinations in Fargate: https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/AWS_Fargate.html
  description = "Memory resources to ECS task in MB (includes all containers in the task)."
}

variable "container_definitions" {
  # - For Fargate, no need to specify cpu/memory for each container
  # - portMappings.hostPort can be zero
  description = "aws_ecs_task_definition.container_definitions, 'containerDefinitions' of the ECS task JSON"
}

variable "ecs_deployment_maximum_percent" {
  type = number
  default = null
  description = "aws_ecs_service.ecs_deployment_maximum_percent (0 to 200)"
}

variable "ecs_deployment_minimum_healthy_percent" {
  type = number
  default = null
  description = "aws_ecs_service.deployment_minimum_healthy_percent (0 to 100)"
}

variable "ecs_service_desired_count" {
  description = "aws_ecs_service.desired_count"
}

variable "volume_name" {
  default = "task_volume"
  description = "volume name for the ECS task."
}

variable "target_container_name" {
  description = "LB target container, which receives traffic from LoadBalancer. Name of one of container in container_definitions."
}

variable "target_container_port" {
  description = "LB target port. Specify portMappings.containerPort value of container_definition"
}

variable "target_group_protocol" {
  default = "HTTP"
  description = "Protocol between LB and container."
}

variable "slow_start_sec" {
  default = 30
  description = "aws_alb_target_group.slow_start, LB don't so much traffic to the container during this period."
}

variable "deregistration_delay" {
  default = 30
  description = "aws_alb_target_group.deregistration_delay, duration of draining state [sec]"
}

variable "health_check_path" {
  description = "healthcheck path"
}

variable "health_check_matcher" {
  default = "200"
  description = "healthcheck successful status code. Can use comma to specify multiple. Can use hypen to specify range."
}

variable "health_check_grace_period_seconds" {
  description = "Do not stop unhealthy container duing this seconds from startup. Specify: Container start-up time + application start-up time + (healthcheck interval * healthy_threshold) + alpha"
}

variable "health_check_interval" {
  default = 10
  description = "healthcheck interval [sec]"
}

variable "health_check_timeout" {
  default = 6
  description = "helthcheck timeout [sec]"
}

variable "unhealthy_threshold" {
  default = 3
  description = "Contignous healthcheck count to mark container as unhealthy"
}

variable "healthy_threshold" {
  default = 3
  description = "Contignous healthcheck count to mark container as healthy"
}

