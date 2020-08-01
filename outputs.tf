output "lambda_region" {
  value = module.lamdba_function.region
}

output "ses_lambda_function_arn" {
  value = module.lamdba_function.ses_lambda_function_arn
}

output "route_53_nameservers" {
  value = module.ses_infra.route_53_nameservers
}

output "dl_ses_topic_arn" {
  value = module.ses_infra.dl_ses_topic_arn
}
