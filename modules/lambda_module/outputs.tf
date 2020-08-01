output "region" {
  value = var.primary_region
}

output "ses_lambda_function_arn" {
  value = aws_lambda_function.email_forwarder_function.arn
}
