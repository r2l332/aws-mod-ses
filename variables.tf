variable "account_id" {
  type        = string
  description = "AWS account ID to use for the new resources"
}

variable "ses_region" {
  type        = string
  description = "AWS region to use SES, SNS and lambda function"
  default     = "eu-west-1"
}

variable "memory_size" {
  type        = number
  description = "Memory size to use in the lambda function for SES."
  default     = 128
}

variable "timeout" {
  type        = number
  description = "Timeout value for lambda"
  default     = 3
}

variable "runtime" {
  type        = string
  description = "Engine runtime for lambda"
  default     = "python3.7"
}

variable "lambda_name" {
  type        = string
  description = "Lambda name for the distribution list"
}

variable "domain" {
  type        = string
  description = "SES domain"
}

variable "main_domain" {
  type        = string
  description = "SES domain"
}


variable "rule_name" {
  type        = string
  description = "SES email rule name"
}

variable "rule_set_name" {
  type        = string
  description = "Receipt rule set name for the SES rule"
}

variable "ses_topic_name" {
  type        = string
  description = "Topic name to create sns topic"
}

variable "dl_email_address" {
  type        = string
  description = "Distributed list for delivery"
}