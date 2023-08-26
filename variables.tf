variable "create_bucket" {
  description = "Whether or not to create an s3 bucket"
  type        = bool
  default     = true
}

variable "create_kms" {
  description = "Whether or not to create an key management service key"
  type        = bool
  default     = true
}

variable "s3_object_tags" {
  description = "S3 object tags (max 10 items)"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

variable "kv_path" {
  description = "key value secret engine mount point"
  type        = string
}

variable "bucket_name" {
  description = "Name of S3 bucket for backup"
  type        = string
}

variable "kms_multi_region" {
  description = "Whether to enable multi-region for KMS key"
  type        = bool
  default     = false
}

variable "kms_deletion_window" {
  description = "KMS key deletion window"
  type        = string
  default     = 14
}
