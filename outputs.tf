output "kms_key_id" {
  description = "ID of the generated KMS key"
  value       = module.kms.key_id
}

output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = module.s3_bucket.s3_bucket_bucket_domain_name
}
