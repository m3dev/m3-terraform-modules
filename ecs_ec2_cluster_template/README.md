# ecs_ec2_cluster_template

ECS nodes with EC2 + AutoScaling.

Also enable [SSM](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ec2-run-command.html) so that you can manage instance with it.

## Prerequisite

- You need to create [aws_ecs_cluster](https://www.terraform.io/docs/providers/aws/r/ecs_cluster.html) itself by yourself

## Variables

See [variables.tf](variables.tf) for parameters.
