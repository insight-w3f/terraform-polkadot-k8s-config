# terraform-polkadot-k8s-config

[![open-issues](https://img.shields.io/github/issues-raw/insight-w3f/terraform-polkadot-k8s-config?style=for-the-badge)](https://github.com/insight-w3f/terraform-polkadot-k8s-config/issues)
[![open-pr](https://img.shields.io/github/issues-pr-raw/insight-w3f/terraform-polkadot-k8s-config?style=for-the-badge)](https://github.com/insight-w3f/terraform-polkadot-k8s-config/pulls)

## Features

WIP - Do not use 

- [ ] Remove provider specifics
    - [ ] Tie in the elb for monitoring endpoints 
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
| helm | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| all\_enabled | Bool to enable all services | `bool` | `true` | no |
| consul\_enabled | Bool to enable consul | `bool` | `true` | no |
| elasticsearch\_enabled | Bool to enable elasticsearch | `bool` | `true` | no |
| prometheus\_enabled | Bool to enable prometheus | `bool` | `true` | no |

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