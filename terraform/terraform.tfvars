aws_region                   = "us-east-1"
project_name                 = "codebolab-website"
environment                  = "production"
domain_name                  = "code.bo"
hosted_zone_name             = "code.bo"
bucket_name                  = "code.bo"
acm_certificate_arn          = "arn:aws:acm:us-east-1:693793396215:certificate/d6a00038-e467-46d8-8caf-44a72ffaac12"
create_route53_alias_records = false

tags = {
  Owner = "codebolab"
}
