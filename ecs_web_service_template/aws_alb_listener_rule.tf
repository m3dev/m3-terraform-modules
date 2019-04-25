resource "aws_alb_listener_rule" "main" {
  count = var.loadbalancer_listener_arns_count

  listener_arn = element(var.loadbalancer_listener_arns, count.index)

  priority = 1000

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.main.arn
  }
  condition {
    field = "host-header"
    # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
    # force an interpolation expression to be interpreted as a list by wrapping it
    # in an extra set of list brackets. That form was supported for compatibilty in
    # v0.11, but is no longer supported in Terraform v0.12.
    #
    # If the expression in the following list itself returns a list, remove the
    # brackets to avoid interpretation as a list of lists. If the expression
    # returns a single list item then leave it as-is and remove this TODO comment.
    values = [
      local.full_domain_name,
    ]
  }
}

