variable "aws_region" {
  description = "AWS region for the main infrastructure resources."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project identifier used for tags and resource names."
  type        = string
  default     = "codebolab-website"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "production"
}

variable "domain_name" {
  description = "Primary domain for the landing page."
  type        = string
  default     = "code.bo"
}

variable "hosted_zone_name" {
  description = "Route53 hosted zone name."
  type        = string
  default     = "code.bo"
}

variable "www_subdomain" {
  description = "WWW alias to be attached to CloudFront."
  type        = string
  default     = "www"
}

variable "bucket_name" {
  description = "S3 bucket name used as CloudFront origin. Defaults to the domain name."
  type        = string
  default     = null
}

variable "acm_certificate_arn" {
  description = "Existing ACM certificate ARN in us-east-1. When provided, this module reuses it instead of creating and validating a new certificate."
  type        = string
  default     = null
  nullable    = true
}

variable "create_route53_alias_records" {
  description = "Whether this module should create the apex and www Route53 alias records."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to apply to resources."
  type        = map(string)
  default     = {}
}
