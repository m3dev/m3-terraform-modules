# Terraform shared modules

## What is this

This module contains reusable terraform modules to reduce boilerplate code. Mainly for M3 company but anyone can use this under [LICENSE](./LICENSE).

For example, you can setup ECS cluster + AutoScailing with [ecs_ec2_cluster_template](./ecs_ec2_cluster_template), no need to write many terraform for every applications.

## Documents

Look `README.md` and `variables.tf` of each module to know it's detail. For example, [ecs_ec2_cluster_template/README.md](./ecs_ec2_cluster_template/README.md) and [ecs_ec2_cluster_template/variables.tf](./ecs_ec2_cluster_template/variables.tf).

## How to use

You can load this module from [GitHub registry](https://www.terraform.io/docs/modules/sources.html#github).

Only what you need to do is to write following:

```
module "esc_ec2_cluster_template" {
  source = "github.com/m3dev/m3-terraform-modules//modules/esc_ec2_cluster_template?ref=1.0.0"

  // ... set input variables, see `variables.tf` of the module.
}
```

Note that there are some key points in the `source` URL (see [official document for detail](https://www.terraform.io/docs/modules/sources.html)):

- Use double slash (`//`) to split repository URL and path from repository root
- Use `ref` to specify tag/branch to use
