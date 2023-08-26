locals {
  kv_path = "kv"
}
#provider "random" {}
provider "vault" {
  address = var.vault_url
}

provider "aws" {
  region                      = "us-west-2"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_requesting_account_id  = true
  default_tags {
    tags = {
      project   = "examples/complete"
      terraform = "True"
    }
  }
}

module "vault_kv_backup" {
  source = "../.."

  kv_path     = local.kv_path
  bucket_name = random_pet.default.id

  create_kms = true
}

#######################
# Additional resources
#######################
resource "random_pet" "default" {
}

resource "vault_policy" "vault_kv_backup_executor" {
  name   = "vault_kv_backup_executor"
  policy = <<EOT

path "${local.kv_path}/*" {
  capabilities = ["read", "list", "create"]
}

path "auth/token/create" {
  capabilities = ["create", "read", "update", "list"]
}
EOT
}

resource "vault_mount" "kv" {
  path = local.kv_path
  type = "kv"
}

resource "vault_auth_backend" "vault_kv_backup_executor" {
  type = "approle"
  path = "vault_kv_backup_executor"
}

resource "vault_approle_auth_backend_role" "vault_kv_backup_executor" {
  backend        = vault_auth_backend.vault_kv_backup_executor.path
  role_name      = "vault_kv_backup_executor"
  token_policies = ["vault_kv_backup_executor"]
}

resource "vault_approle_auth_backend_role_secret_id" "id" {
  backend   = vault_auth_backend.vault_kv_backup_executor.path
  role_name = vault_approle_auth_backend_role.vault_kv_backup_executor.role_name
}

resource "vault_approle_auth_backend_login" "login" {
  backend   = vault_auth_backend.vault_kv_backup_executor.path
  role_id   = vault_approle_auth_backend_role.vault_kv_backup_executor.role_id
  secret_id = vault_approle_auth_backend_role_secret_id.id.secret_id
}

resource "vault_kv_secret" "example" {
  count     = 5
  data_json = jsonencode({ "foo${count.index}" : "bar.${count.index}" })
  path      = "${local.kv_path}/example_${count.index}"

  depends_on = [
    vault_policy.vault_kv_backup_executor,
    vault_approle_auth_backend_login.login,
    vault_mount.kv
  ]
}
