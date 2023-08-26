# Vault kv backup Terraform module

Terraform module, which creates an S3 backup of the kv store store secrets for Hashicorp Vault.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Usage

A Terraform module designed to store Hashicorp Vault's key-value (kv) secrets in an AWS S3 bucket, compressed in ZIP format.

This module leverages AWS [KMS](https://github.com/terraform-aws-modules/terraform-aws-kms) and [S3](https://github.com/terraform-aws-modules/terraform-aws-s3-bucket) services and reuses existing infrastructure components.

terraform-aws-s3-bucket

```hcl
module "vault_kv_backup" {
  source = "../.."

  kv_path     = local.kv_path
  bucket_name = random_pet.default.id

  create_kms = true
}
```
## Examples

[Storing secrets for kv store](https://github.com/99/terraform-vault-s3-backup/tree/main/examples/complete)
Storing secrets for kv version2 store (WIP)

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/99/terraform-vault-s3-backup/issues/new) section.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.4.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.9.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 3.15.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | >= 2.4.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.9.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.2 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | >= 3.15.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms"></a> [kms](#module\_kms) | terraform-aws-modules/kms/aws | 1.5.0 |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | 3.15.0 |

## Resources

| Name | Type |
|------|------|
| [aws_s3_object.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [null_resource.remove_zip](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [archive_file.zip](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [vault_kv_secret.secrets](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/kv_secret) | data source |
| [vault_kv_secrets_list.kv](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/kv_secrets_list) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of S3 bucket for backup | `string` | n/a | yes |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | Whether or not to create an s3 bucket | `bool` | `true` | no |
| <a name="input_create_kms"></a> [create\_kms](#input\_create\_kms) | Whether or not to create an key management service key | `bool` | `true` | no |
| <a name="input_kms_deletion_window"></a> [kms\_deletion\_window](#input\_kms\_deletion\_window) | KMS key deletion window | `string` | `14` | no |
| <a name="input_kms_multi_region"></a> [kms\_multi\_region](#input\_kms\_multi\_region) | Whether to enable multi-region for KMS key | `bool` | `false` | no |
| <a name="input_kv_path"></a> [kv\_path](#input\_kv\_path) | key value secret engine mount point | `string` | n/a | yes |
| <a name="input_s3_object_tags"></a> [s3\_object\_tags](#input\_s3\_object\_tags) | S3 object tags (max 10 items) | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | ID of the generated KMS key |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | S3 bucket name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-vpc/tree/master/LICENSE) for full details.

## Additional information for users from Russia and Belarus

* Russia has [illegally annexed Crimea in 2014](https://en.wikipedia.org/wiki/Annexation_of_Crimea_by_the_Russian_Federation) and [brought the war in Donbas](https://en.wikipedia.org/wiki/War_in_Donbas) followed by [full-scale invasion of Ukraine in 2022](https://en.wikipedia.org/wiki/2022_Russian_invasion_of_Ukraine).
* Russia has brought sorrow and devastations to millions of Ukrainians, killed [thousands of innocent people](https://www.ohchr.org/en/news/2023/06/ukraine-civilian-casualty-update-19-june-2023), damaged thousands of buildings including [critical infrastructure](https://www.aljazeera.com/gallery/2022/12/17/russia-launches-another-major-missile-attack-on-ukraine), caused ecocide by [blowing up a dam](https://www.reuters.com/world/europe/ukraine-security-service-says-it-intercepted-call-proving-russia-destroyed-2023-06-09/), [bombed theater](https://www.cnn.com/2022/03/16/europe/ukraine-mariupol-bombing-theater-intl/index.html) in Mariupol that had "Children" marking on the ground, [raped men and boys](https://www.theguardian.com/world/2022/may/03/men-and-boys-among-alleged-victims-by-russian-soldiers-in-ukraine), [deported children](https://www.bbc.com/news/world-europe-64992727) in the occupied territoris, and forced [millions of people](https://www.unrefugees.org/emergencies/ukraine/) to flee.
* [Putin khuylo!](https://en.wikipedia.org/wiki/Putin_khuylo!)
