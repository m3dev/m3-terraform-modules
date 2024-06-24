# ecs_service_template

ECS service + ALB target/listener + Route53 record.

## Prerequisite

- Prepare Route53 hosted zone
- Prepare ALB
  - You can use [alb_template](../alb_template) to setup ALB
- Prepare ECS cluster if you don't use Fargate
  - You can use [ecs_ec2_cluster_template](../ecs_ec2_cluster_template) to setup ECS cluster

## Variables

See [variables.tf](variables.tf) for parameters.
