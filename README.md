# How to bulk create nsg rules based on CSV

1. You need create multiple CSV for each environnement like the model in UAT.csv
2. launch the PowerShell Script to split it correctly
3. terraform init && terraform plan

## Providers

| Name | Version |
|------|---------|
| azurerm | =2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| filePath | n/a | `string` | `"deploy/module/nsg/"` | no |
| nsg\_name | n/a | `any` | n/a | yes |
| rg\_location | n/a | `any` | n/a | yes |
| rg\_name | n/a | `any` | n/a | yes |
| tags | n/a | `any` | n/a | yes |
| vm\_usage | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| nsg\_id | n/a |
| rg\_location | n/a |
| rg\_name | n/a |

