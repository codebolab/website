# code.bo DNS Ownership

## Hallazgos

- El dominio `code.bo` ya parece estar publicado en Route53 por otro proyecto Terraform.
- El apex `code.bo` resuelve actualmente a una IP pública.
- `www.code.bo` no responde actualmente con un registro `A` público.
- En ACM `us-east-1` existen certificados emitidos para `*.code.bo` y `code.bo`.
- El wildcard `*.code.bo` no cubre el apex `code.bo`.
- El certificado correcto para CloudFront de esta landing es `code.bo`, porque incluye `www.code.bo` como SAN.

## Riesgo

No es una buena práctica que dos estados de Terraform distintos administren los mismos registros DNS (`code.bo`, `www.code.bo`) dentro de la misma zona.

Eso generaría drift, errores en `apply` o sobrescrituras entre proyectos.

## Recomendación

Mantener un solo owner para Route53 de `code.bo`:

- este repo administra S3, CloudFront y despliegue del sitio
- el proyecto `devops/terraform` mantiene la zona y los registros DNS de `code.bo`

## Configuración sugerida en este repo

Usar estas variables de Terraform o GitHub Actions:

```hcl
domain_name                  = "code.bo"
hosted_zone_name             = "code.bo"
bucket_name                  = "code.bo"
create_route53_alias_records = false
acm_certificate_arn          = "arn:aws:acm:us-east-1:693793396215:certificate/d6a00038-e467-46d8-8caf-44a72ffaac12"
```

Esto permite que CloudFront use un certificado ya existente sin intentar crear o tomar ownership de los alias DNS desde este state.

## Registros a mantener en el repo de DNS

En el proyecto que ya administra `code.bo`, los alias deberían apuntar al CloudFront de este sitio:

```hcl
resource "aws_route53_record" "code_bo_alias_a" {
  zone_id = aws_route53_zone.code_bo.zone_id
  name    = "code.bo"
  type    = "A"

  alias {
    name                   = var.website_cloudfront_domain_name
    zone_id                = var.website_cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "code_bo_alias_aaaa" {
  zone_id = aws_route53_zone.code_bo.zone_id
  name    = "code.bo"
  type    = "AAAA"

  alias {
    name                   = var.website_cloudfront_domain_name
    zone_id                = var.website_cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_code_bo_alias_a" {
  zone_id = aws_route53_zone.code_bo.zone_id
  name    = "www.code.bo"
  type    = "A"

  alias {
    name                   = var.website_cloudfront_domain_name
    zone_id                = var.website_cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_code_bo_alias_aaaa" {
  zone_id = aws_route53_zone.code_bo.zone_id
  name    = "www.code.bo"
  type    = "AAAA"

  alias {
    name                   = var.website_cloudfront_domain_name
    zone_id                = var.website_cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}
```

Los valores `website_cloudfront_domain_name` y `website_cloudfront_hosted_zone_id` salen de los outputs de este repo.
