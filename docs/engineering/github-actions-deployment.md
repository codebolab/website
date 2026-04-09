# GitHub Actions Deployment

## Objetivo

Automatizar dos flujos de trabajo del repositorio:

- aplicar cambios de infraestructura en AWS con Terraform
- publicar la landing de Astro en S3 y limpiar caché de CloudFront

## Workflows

Los workflows ahora siguen el mismo patrón general usado en `specboard`:

- un job de validación para pull requests y cambios en `main`
- un job de deploy separado para `push` a `main` y `workflow_dispatch`
- autenticación AWS por OIDC con un role compartido cuando exista
- concurrencia por PR o ref para evitar ejecuciones redundantes

### `terraform.yml`

- Ejecuta `terraform fmt`, `terraform validate` y `terraform plan` en pull requests y cambios a `main`.
- Ejecuta `terraform apply` automáticamente en `push` a `main` y en ejecuciones manuales.
- Usa backend remoto en S3, igual que el flujo manual documentado en `terraform/README.md`.

### `deploy-website.yml`

- Ejecuta un job de validación con `yarn install` y `yarn build`.
- Ejecuta el deploy del sitio en `push` a `main` y en ejecuciones manuales.
- Lee `site_bucket_name` y `cloudfront_distribution_id` desde el estado remoto de Terraform.
- Hace `aws s3 sync` del directorio `dist/`.
- Ejecuta invalidación de CloudFront para publicar los cambios.

## Configuración requerida en GitHub

### Secrets

- `AWS_GITHUB_DEPLOY_ROLE_ARN` recomendado: IAM role que GitHub Actions asumirá vía OIDC.
- `AWS_ROLE_TO_ASSUME` alternativo por compatibilidad con la versión anterior del workflow.
- `TERRAFORM_STATE_BUCKET`: bucket S3 donde vive el estado remoto de Terraform.

### Repository variables

- `AWS_REGION`: región principal de AWS. Si no se define, el workflow usa `us-east-1`.
- `TERRAFORM_STATE_KEY`: key del estado remoto. Si no se define, usa `codebolab/website/terraform.tfstate`.
- `TF_VAR_DOMAIN_NAME`
- `TF_VAR_HOSTED_ZONE_NAME`
- `TF_VAR_BUCKET_NAME` opcional
- `TF_VAR_ACM_CERTIFICATE_ARN` opcional
- `TF_VAR_CREATE_ROUTE53_ALIAS_RECORDS` opcional
- `TF_VAR_PROJECT_NAME` opcional
- `TF_VAR_ENVIRONMENT` opcional
- `TF_VAR_WWW_SUBDOMAIN` opcional

Terraform leerá estas variables automáticamente como inputs.

## Recomendación para `code.bo`

Si la zona `code.bo` ya está administrada por otro proyecto Terraform, evita duplicar ownership de DNS:

- reutiliza un certificado ACM existente con `TF_VAR_ACM_CERTIFICATE_ARN`
- configura `TF_VAR_CREATE_ROUTE53_ALIAS_RECORDS=false`
- crea o actualiza los alias `code.bo` y `www.code.bo` en el proyecto que ya administra Route53 para esa zona

## Suposiciones

- La rama de despliegue es `main`.
- La infraestructura ya fue creada o podrá ser creada desde el workflow de Terraform.
- La cuenta de AWS ya tiene configurado el trust policy para OIDC con GitHub Actions.
