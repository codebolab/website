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
- `tags`

Para `code.bo`, este repositorio ya incluye un `terraform.tfvars` listo para producción que:

- reutiliza el certificado ACM existente `code.bo` en `us-east-1`
- administra los alias Route53 de la landing desde este state

Los records existentes `code.bo` y `www.code.bo` tipo `A` y `AAAA` fueron importados y quedan administrados por este repo. Después de confirmar el plan en este repo, el ownership anterior debe removerse del state de `devops` con `terraform state rm`, sin destruir los records reales en AWS.

## Uso

```bash
terraform init

terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

## Reutilizar Route53 o ACM existentes

Si `code.bo` ya está administrado por otro proyecto Terraform, la práctica recomendada es no gestionar los mismos registros desde dos estados distintos. Para esta landing, este repo toma ownership de los alias Route53 de `code.bo`.

En ese caso:

- reutiliza el certificado existente con `acm_certificate_arn`
- importa cualquier record existente antes de aplicar, por ejemplo:

```bash
AWS_PROFILE=codebo terraform import -var-file="terraform.tfvars" aws_route53_record.apex 'Z0044523QCA81UB2LNKN_code.bo_A'
AWS_PROFILE=codebo terraform import -var-file="terraform.tfvars" aws_route53_record.apex_ipv6 'Z0044523QCA81UB2LNKN_code.bo_AAAA'
AWS_PROFILE=codebo terraform import -var-file="terraform.tfvars" aws_route53_record.www 'Z0044523QCA81UB2LNKN_www.code.bo_A'
AWS_PROFILE=codebo terraform import -var-file="terraform.tfvars" aws_route53_record.www_ipv6 'Z0044523QCA81UB2LNKN_www.code.bo_AAAA'
```

- remueve el resource equivalente del state anterior con `terraform state rm`, no con `terraform destroy`

Nota sobre ACM para `code.bo`:

- el certificado `*.code.bo` no cubre el apex `code.bo`
- el certificado correcto para esta landing es el de `code.bo` con SAN `www.code.bo`

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

## Recuperación de estado

Si un `terraform apply` falla con `Failed to persist state to backend`, Terraform puede escribir un archivo local `errored.tfstate`. No ejecutes otro `apply` antes de recuperar ese estado, porque podrías bifurcar el estado remoto.

Para recuperarlo:

```bash
terraform init
terraform state push errored.tfstate
```

En GitHub Actions, el workflow de infraestructura guarda `errored.tfstate` como artifact temporal cuando existe.
