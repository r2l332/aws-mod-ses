variable "ses_region" {
  type        = string
  description = "AWS region to use SES, SNS and lambda function"
  default     = "eu-west-1"
}

variable "domain" {
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

variable "ses_lambda_arn" {
  type        = string
  description = "Lambda ARN"
}
