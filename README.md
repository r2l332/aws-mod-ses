# Module for SES Lambda

## Requirements

- Own a valid domain to register in SES
- The domain will be registered in AWS (not an external domain provider)

| Name | Version |
|------|---------|
| aws | n/a |
 
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| account\_id | AWS account ID to use for the new resources | `string` | n/a | yes |
| dl\_email\_address | Distributed list for delivery | `string` | n/a | yes |
| domain | SES domain | `string` | n/a | yes |
| lambda\_name | Lambda name for the distribution list | `string` | n/a | yes |
| main\_domain | SES domain | `string` | n/a | yes |
| memory\_size | Memory size to use in the lambda function for SES. | `number` | `128` | no |
| rule\_name | SES email rule name | `string` | n/a | yes |
| rule\_set\_name | Receipt rule set name for the SES rule | `string` | n/a | yes |
| runtime | Engine runtime for lambda | `string` | `"python3.7"` | no |
| ses\_region | AWS region to use SES, SNS and lambda function | `string` | `"eu-west-1"` | no |
| ses\_topic\_name | Topic name to create sns topic | `string` | n/a | yes |
| timeout | Timeout value for lambda | `number` | `3` | no |

## Outputs

| Name | Description |
|------|-------------|
| dl\_ses\_topic\_arn | n/a |
| lambda\_region | n/a |
| route\_53\_nameservers | n/a |
| ses\_lambda\_function\_arn | n/a |
