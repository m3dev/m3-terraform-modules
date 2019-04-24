output "lb_zone_id" {
  value = "${aws_lb.main.zone_id}"
}

output "listener_arns" {
  value = [
    "${aws_lb_listener.http.arn}",
    "${aws_lb_listener.https.arn}",
  ]
}

output "default_target_group_arn" {
  value = "${aws_lb_target_group.default-target-group.arn}"
}

output "security_group_id" {
  value = "${aws_security_group.loadbalancer.id}"
}
