data "vault_kv_secrets_list" "kv" {
  path = var.kv_path
}

data "vault_kv_secret" "secrets" {
  for_each = nonsensitive(toset(data.vault_kv_secrets_list.kv.names))

  path = "${data.vault_kv_secrets_list.kv.path}/${each.value}"
}


data "archive_file" "zip" {
  type = "zip"

  output_path = "${path.root}/${formatdate("YY_MM_DD", plantimestamp())}.zip"

  dynamic "source" {
    for_each = data.vault_kv_secret.secrets
    content {
      content  = source.value.data_json
      filename = "${formatdate("YY_MM_DD", plantimestamp())}/${source.key}.json"
      # filename = "${formatdate("YY_MM_DD", time_rotating.now.id)}/${source.key}.json"
    }
  }
}


module "s3_bucket" {

  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.15.0"

  create_bucket           = var.create_bucket
  bucket                  = var.bucket_name
  block_public_policy     = true
  block_public_acls       = true
  restrict_public_buckets = true
  ignore_public_acls      = true
  versioning = {
    enabled = true
  }
  # Allow deletion of non-empty bucket
  force_destroy = true

  server_side_encryption_configuration = {
    rule = {
      bucket_key_enabled = true
      apply_server_side_encryption_by_default = {
        kms_master_key_id = module.kms.key_id
        sse_algorithm     = "aws:kms"
      }
    }
  }
  lifecycle_rule = [
    {
      id                                     = "incomplete_multipart_upload"
      enabled                                = true
      abort_incomplete_multipart_upload_days = 1

    },
  ]
  tags = var.tags
}

resource "aws_s3_object" "backup" {
  key        = data.archive_file.zip.output_path
  bucket     = module.s3_bucket.s3_bucket_id
  source     = data.archive_file.zip.output_path
  kms_key_id = module.kms.key_arn

  tags = var.s3_object_tags

}

resource "null_resource" "remove_zip" {
  triggers = {
    archive_md5 = data.archive_file.zip.output_md5
  }
  provisioner "local-exec" {
    command = "rm -rf ${data.archive_file.zip.output_path}"
  }
  depends_on = [
    aws_s3_object.backup
  ]
}

module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "1.5.0"

  create = var.create_kms

  description             = "This key is used to encrypt objects"
  deletion_window_in_days = var.kms_deletion_window
  enable_key_rotation     = true
  multi_region            = var.kms_multi_region

  tags = var.tags

}
