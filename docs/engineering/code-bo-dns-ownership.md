# code.bo DNS Ownership

## Hallazgos

- La hosted zone pública de Route53 para `code.bo` es `Z0044523QCA81UB2LNKN`.
- El apex `code.bo` tipo `A` existe y apunta como alias a CloudFront `d374w22tomoq7o.cloudfront.net` con hosted zone `Z2FDTNDATAQYW2`.
- `www.code.bo` no responde actualmente con un registro `A` público.
- En ACM `us-east-1` existen certificados emitidos para `*.code.bo` y `code.bo`.
- El wildcard `*.code.bo` no cubre el apex `code.bo`.
- El certificado correcto para CloudFront de esta landing es `code.bo`, porque incluye `www.code.bo` como SAN.
- Los records `code.bo` y `www.code.bo` tipo `A` y `AAAA` fueron importados en este repo.

## Riesgo

No es una buena práctica que dos estados de Terraform distintos administren los mismos registros DNS (`code.bo`, `www.code.bo`) dentro de la misma zona.

Eso generaría drift, errores en `apply` o sobrescrituras entre proyectos.

## Recomendación

Mantener un solo owner para Route53 de `code.bo`:

- este repo administra S3, CloudFront y despliegue del sitio
- este repo administra siempre los alias DNS de la landing (`code.bo` y `www.code.bo`)
- el proyecto `devops/terraform` mantiene la zona y deja de administrar el record apex `A`

## Configuración sugerida en este repo

Usar estas variables de Terraform o GitHub Actions:

```hcl
domain_name                  = "code.bo"
hosted_zone_name             = "code.bo"
bucket_name                  = "code.bo"
acm_certificate_arn          = "arn:aws:acm:us-east-1:693793396215:certificate/d6a00038-e467-46d8-8caf-44a72ffaac12"
```

Esto permite que CloudFront use un certificado ya existente y que este state sea el owner de los alias DNS de la landing.

## Migración de state completada

Los records existentes se importaron en este repo con:

```bash
AWS_PROFILE=codebo terraform import -var-file="terraform.tfvars" aws_route53_record.apex 'Z0044523QCA81UB2LNKN_code.bo_A'
AWS_PROFILE=codebo terraform import -var-file="terraform.tfvars" aws_route53_record.apex_ipv6 'Z0044523QCA81UB2LNKN_code.bo_AAAA'
AWS_PROFILE=codebo terraform import -var-file="terraform.tfvars" aws_route53_record.www 'Z0044523QCA81UB2LNKN_www.code.bo_A'
AWS_PROFILE=codebo terraform import -var-file="terraform.tfvars" aws_route53_record.www_ipv6 'Z0044523QCA81UB2LNKN_www.code.bo_AAAA'
```

Después del import, validar con:

```bash
AWS_PROFILE=codebo terraform plan -var-file="terraform.tfvars"
```

El plan esperado no debe modificar, crear ni destruir los records DNS si todos existen y ya están importados.

Una vez confirmado el import en este repo, remover el ownership anterior del state de `/Users/josezambrana/projects/devops` sin destruir el record real en AWS:

```bash
cd /Users/josezambrana/projects/devops/terraform
AWS_PROFILE=codebo terraform state rm aws_route53_record.code_bo_A
```
