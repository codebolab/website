output "site_bucket_name" {
  description = "S3 bucket that stores the built site."
  value       = aws_s3_bucket.site.id
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID."
  value       = aws_cloudfront_distribution.site.id
}

output "cloudfront_domain_name" {
  description = "CloudFront domain name."
  value       = aws_cloudfront_distribution.site.domain_name
}

output "cloudfront_hosted_zone_id" {
  description = "CloudFront hosted zone ID for Route53 alias records."
  value       = aws_cloudfront_distribution.site.hosted_zone_id
}

output "certificate_arn" {
  description = "ACM certificate ARN used by CloudFront."
  value       = local.certificate_arn
}

output "website_url" {
  description = "Primary website URL."
  value       = "https://${var.domain_name}"
}
