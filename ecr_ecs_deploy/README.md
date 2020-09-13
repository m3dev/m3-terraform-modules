# ecr_ecs_deploy

Updates ECS service to force a new deployment when new Docker image is pushed to ECR repository.

It must be useful for a case that ECS task definition refers docker image with ":latest" (or other fixed) tag.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| docker\_image\_tags | Docker image tag to watch. | `string` | `"latest"` | no |
| ecr\_repository\_name | Name of ECR repository to watch. | `string` | n/a | yes |
| ecs\_cluster\_name | Name of ECS cluster which the ECS service belongs to | `string` | n/a | yes |
| ecs\_service\_name | Arn of ECS service to update | `string` | n/a | yes |
| name\_prefix | Prefix which is added for some resources. | `string` | `""` | no |

## Outputs

No output.
