# Terraform shared modules

## What is this

Reusable terraform modules. They are made for M3,Inc.'s internal use. But, anyone able to use them under [LICENSE](./LICENSE).

## Modules

**Setting up services**:

| Module | Description |
| -------------: | :------------- |
| [alb_template](./alb_template) | ALB + SSL certificate. |
| [ecr_repository_template](./ecr_repository_template) | ECR repository with Lifecycle policy. |
| [ecs_ec2_cluster_template](./ecs_ec2_cluster_template) | ECS nodes with EC2 + AutoScaling. |
| [ecs_web_service_template](./ecs_web_service_template) | ECS service + ALB target/listener + Route53 record.|

**Monitoring**:

| Module | Description |
| -------------: | :------------- |
| [guardduty_slack](./guardduty_slack) | GuardDuty alerts in Slack. |
| [lambda_monitoring](./lambda_monitoring) | CloudWatch monitoring (alarm) for AWS lambda. |

See `README.md` and `variables.tf` of each module for details.

## Install

We can use modules with `module` blocks:

```
module "esc_ec2_cluster_template" {
  source = "github.com/m3dev/m3-terraform-modules//ecs_ec2_cluster_template?ref=495ff58"

  // ... set input variables, see `variables.tf` of the module.
}
```

Note:

- You have to use double slash (`//`) to split repository URL and path from repository root.
- You should specify tag/branch/revision with `ref`, or your code might be broken when the `master` branch changed.

See [the official document](https://www.terraform.io/docs/modules/sources.html)) for details.
