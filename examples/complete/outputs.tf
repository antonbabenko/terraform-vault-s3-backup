output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = module.vault_kv_backup.s3_bucket_name
}
