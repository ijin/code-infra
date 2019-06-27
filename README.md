# Terraform for CodePipeline

## comman infra

```
cd common
terraform plan
terraform apply
```

## environment specific infra

environments (staging, demo) map to **terraform workspaces**.

```
terraform workspace list
terraform workspace select staging
terraform plan
terraform apply
```

## notes

may need to initialize

```
terraform init
terraform get
```

