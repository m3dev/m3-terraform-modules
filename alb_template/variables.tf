variable "vpc_id" {
  description = "ID of the VPC to place loadbalancer."
}

variable "subnet_ids" {
  type        = list(string)
  description = "ID of subnets to place loadbalancer"
}

variable "domain_name" {
  description = "Fully Qualified Domain Name. Used to create Route53 record, SSL certificate. And also used for naming loadbalancer."
}

variable "route53_zone_id" {
  description = "ID of the Route53 hosted zone to create DNS record within."
}

variable "access_logs_bucket" {
  description = "Name of S3 bucket to store access logs"
}

// ------------ Optional config ------------

variable "idle_timeout" {
  default     = 300
  description = "Max idle time of the connection in ALB"
}

variable "acm_certificate_alternative_names" {
  type        = list(string)
  default     = []
  description = "Alternative names of the SSL certificate. If you use CNAME for the domain_name, you should set FQDN of CNAMEs to allow access from the CNAMEs."
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of CIDR blokcs to allow access to the loadbalancer."
}

variable "target_subnet_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of CIDR blocks to allow access FROM the loadbalancer to the target."
}

variable "default_target_group_port" {
  default     = 80
  description = "Port number of the default target group (= port number of the backend)."
}

variable "http_port" {
  default     = 80
  description = "TCP port number of incoming HTTP"
}

variable "https_port" {
  default     = 443
  description = "TCP port number of incoming HTTPS"
}

