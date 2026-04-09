# Terraform

Infraestructura mínima para desplegar este landing estático en AWS con:

- S3 privado para el contenido
- CloudFront con OAC
- ACM para TLS
- Route53 para DNS
- backend remoto en S3 para el estado de Terraform

## Recursos incluidos

- `aws_s3_bucket`
- `aws_s3_bucket_public_access_block`
- `aws_s3_bucket_server_side_encryption_configuration`
- `aws_s3_bucket_versioning`
- `aws_cloudfront_origin_access_control`
- `aws_cloudfront_distribution`
- `aws_acm_certificate`
- `aws_acm_certificate_validation`
- `aws_route53_record`

## Backend S3

Este proyecto sigue el mismo enfoque que `specboard`: el backend remoto está declarado directamente en la configuración de Terraform.

- bucket: `codebolab-terraform-states`
- key: `codebolab/website/terraform.tfstate`
- region: `us-east-1`

## Variables

Puedes copiar `terraform.tfvars.example` a `terraform.tfvars` y ajustar:

- `domain_name`
- `hosted_zone_name`
- `bucket_name` si no quieres usar el dominio como nombre del bucket
- `acm_certificate_arn` si ya existe un certificado administrado en otro stack
- `create_route53_alias_records` si el DNS de la zona vive en otro proyecto Terraform
- `tags`

## Uso

```bash
terraform init

terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

## Reutilizar Route53 o ACM existentes

Si `code.bo` ya está administrado por otro proyecto Terraform, la práctica recomendada es no gestionar los mismos registros desde dos estados distintos.

En ese caso:

- reutiliza el certificado existente con `acm_certificate_arn`
- desactiva la creación de alias con `create_route53_alias_records = false`
- crea los alias `code.bo` y `www.code.bo` en el proyecto que ya administra la zona usando los outputs `cloudfront_domain_name` y `cloudfront_hosted_zone_id`

## Deploy del sitio

Después de aplicar la infraestructura:

```bash
ASTRO_TELEMETRY_DISABLED=1 yarn build
aws s3 sync dist/ s3://YOUR_BUCKET_NAME --delete
aws cloudfront create-invalidation --distribution-id YOUR_DISTRIBUTION_ID --paths "/*"
```

## GitHub Actions

El repositorio incluye workflows para automatizar infraestructura y despliegue del sitio:

- `.github/workflows/terraform.yml`
- `.github/workflows/deploy-website.yml`

La documentación de variables y secrets requeridos está en `docs/engineering/github-actions-deployment.md`.
