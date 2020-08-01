variable "primary_region" {
  description = "AWS region to deploy lambda function"
  type        = string
}

variable "domain" {
  type        = string
  description = "SES domain"
}

variable "memory_size" {
  description = "Memory size to use in the lambda function."
  type        = number
}

variable "timeout" {
  description = "Timeout value for lambda"
  type        = number
}

variable "runtime" {
  description = "Engine runtime for lambda"
  type        = string
}

variable "lambda_name" {
  type        = string
  description = "The lambda name"
}

variable "dl_email_address" {
  type        = string
  description = "Distributed list for delivery"
}

variable "account_id" {
  description = "AWS account to use"
  type        = string
}

variable "source_arn_lambda" {
  description = "ARN of SNS topic to give permission to invoke the lambda function"
  type        = string
}
