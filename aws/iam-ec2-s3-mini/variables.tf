variable "region" {
  type    = string
  default = "us-east-2" # Ohio
}

variable "bucket_name" {
  type        = string
  description = "Existing S3 bucket name"
}

variable "project_suffix" {
  type    = string
  default = "gerard"
}
