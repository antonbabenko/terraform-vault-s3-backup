# Example using terraform-vault-s3-backup

Example using terraform-vault-s3-backup terraform module to generate an S3 backup for HashiCorp Vault's key-value (kv) secrets.

Configuration in this directory creates:
 - Hashicorp Vault server in "dev" mode
 - KV store 
 - s3 bucket 
 - kms key



## Usage

### Setup 

Installation of Hashciorp Vault can be done in different ways. Please refer to official [HashiCorp Vault documentation](https://developer.hashicorp.com/vault/docs/install)
- [Vault "Dev" server mode concept description](https://developer.hashicorp.com/vault/docs/concepts/dev-server)
- [Starting the Dev Server](https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-dev-server)
Dev-mode is intended for experimenting with Vault features and should **NOT be used in production**



#### Vault pre-test setup to run this example

```shell
vault server -dev 
export VAULT_ADDR='http://127.0.0.1:8200'
```
- create kv store
- add approle and policy for approle (using approle for this example only )
- enable kv engine
- add kv secrets

```shell
terraform init
terraform plan --target vault_kv_secret.example
terraform apply --target vault_kv_secret.example
```
#### Commands to run an example


```shell
terraform plan 
terraform apply 
```
#### Example outputs

```
s3_bucket_name = "mature-gelding.s3.amazonaws.com
```

#### Example cleanup


```shell
terraform destroy
```
stop Vault dev-mode server.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.4.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.1.2 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 3.15.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.1.2 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | >= 3.15.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vault_kv_backup"></a> [vault\_kv\_backup](#module\_vault\_kv\_backup) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [random_pet.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [vault_approle_auth_backend_login.login](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_login) | resource |
| [vault_approle_auth_backend_role.vault_kv_backup_executor](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role) | resource |
| [vault_approle_auth_backend_role_secret_id.id](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role_secret_id) | resource |
| [vault_auth_backend.vault_kv_backup_executor](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend) | resource |
| [vault_kv_secret.example](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret) | resource |
| [vault_mount.kv](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_policy.vault_kv_backup_executor](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vault_url"></a> [vault\_url](#input\_vault\_url) | Vault URL for connection | `string` | `"http://127.0.0.1:8200"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | S3 bucket name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
