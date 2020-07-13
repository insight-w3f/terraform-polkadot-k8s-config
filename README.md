# terraform-polkadot-k8s-config

[![open-issues](https://img.shields.io/github/issues-raw/insight-w3f/terraform-polkadot-k8s-config?style=for-the-badge)](https://github.com/insight-w3f/terraform-polkadot-k8s-config/issues)
[![open-pr](https://img.shields.io/github/issues-pr-raw/insight-w3f/terraform-polkadot-k8s-config?style=for-the-badge)](https://github.com/insight-w3f/terraform-polkadot-k8s-config/pulls)

## Features

WIP - Do not use 

- [ ] Remove provider specifics
    - [ ] Parameterize consul configs to tie into global vars 

- [ ] Tests 
    - [ ] AWS
    - [ ] Azure
    - [ ] GCP
         
- [ ] Ouptuts 
- [ ] Tons of other stuff

### Files that need generalization 

- es.yml
- consul.yml

## Terraform Versions

For Terraform v0.12.0+

## Usage

```hcl-terraform
module "this" {
  source = "github.com/insight-w3f/terraform-polkadot-k8s-config"
}
```
## Examples

- [defaults](https://github.com/insight-w3f/terraform-polkadot-k8s-config/tree/master/examples/defaults)

## Known  Issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| helm | n/a |
| kubernetes | n/a |
| local | n/a |
| null | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| acme\_server | Full URI of the certificate issuing server | `string` | `"https://acme-staging-v02.api.letsencrypt.org/directory"` | no |
| alertmanager\_subdomain | The subdomain for AlertManager | `string` | `"alertmanager"` | no |
| all\_enabled | Bool to enable all services | `bool` | `true` | no |
| aws\_worker\_arn | ARN for EKS worker nodes | `string` | `""` | no |
| azure\_resource\_group | The Azure resource group | `string` | `""` | no |
| azure\_service\_principal\_key | Contents of the JSON file for the Azure service principal | `string` | `""` | no |
| cert\_manager\_enabled | Bool to enable external cert-manager | `bool` | `true` | no |
| cert\_manager\_issuer\_secret\_name | k8s secret name for this issuer | `string` | `"letsencrypt-issuer-account-key"` | no |
| cloud\_platform | The cloud platform where the cluster is deployed | `string` | n/a | yes |
| consul\_enabled | Bool to enable consul | `bool` | `true` | no |
| deployment\_domain\_name | The domain name that will host the deployment | `string` | `""` | no |
| do\_token | The DO API token | `string` | `""` | no |
| elasticsearch\_enabled | Bool to enable elasticsearch | `bool` | `true` | no |
| external\_dns\_enabled | Bool to enable external DNS controller | `bool` | `true` | no |
| google\_project | Name of GCP project | `string` | `""` | no |
| google\_service\_account\_key | Contents of the JSON file for the GCP service account | `string` | `""` | no |
| grafana\_subdomain | The subdomain for Grafana | `string` | `"grafana"` | no |
| issuer\_name | k8s resource name for your certificate issuer (e.g. letsencrypt) | `string` | `"letsencrypt"` | no |
| kubeconfig | The base64-encoded kubeconfig file contents for the cluster to apply CRDs to | `string` | `""` | no |
| lb\_endpoint | URI/IP to the load balancer endpoint | `string` | `""` | no |
| nginx\_ingress\_enabled | Bool to enable nginx ingress | `bool` | `true` | no |
| prometheus\_enabled | Bool to enable prometheus | `bool` | `true` | no |
| prometheus\_password | Password used for Prometheus authentication | `string` | `"node_exporter_password"` | no |
| prometheus\_subdomain | The subdomain for Prometheus | `string` | `"prometheus"` | no |
| prometheus\_user | Username used for Prometheus authentication | `string` | `"node_exporter_user"` | no |
| region | The region where the cluster is deployed | `string` | n/a | yes |
| slack\_api\_key | Your Slack API key to receive alerts | `string` | `""` | no |
| user\_email | Email address of user to be notifed by certificate issuer about expiry, etc. | `string` | `""` | no |
| wait\_on | Variable to trick TF into waiting for everything else to finish | `string` | `""` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Testing
This module has been packaged with terratest tests

To run them:

1. Install Go
2. Run `make test-init` from the root of this repo
3. Run `make test` again from root

## Authors

Module managed by [insight-w3f](https://github.com/insight-w3f)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.