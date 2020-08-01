module "r53_record" {
  source = "./modules/r53_module"
  domain = var.domain
  providers = {
    aws = aws.primary
  }
}

module "lamdba_function" {
  source  = "./modules/lambda_module"
  timeout = var.timeout
  runtime = var.runtime

  memory_size = var.memory_size
  lambda_name = var.lambda_name
  account_id  = data.aws_caller_identity.current.account_id

  primary_region    = var.ses_region
  dl_email_address  = var.dl_email_address
  domain            = var.domain
  source_arn_lambda = module.ses_infra.dl_ses_topic_arn
  providers = {
    aws = aws.primary
  }
}

module "ses_infra" {
  source     = "./modules/ses_module"
  domain     = var.domain
  ses_region = var.ses_region

  rule_name        = var.rule_name
  rule_set_name    = var.rule_set_name
  dl_email_address = var.dl_email_address
  ses_lambda_arn   = module.lamdba_function.ses_lambda_function_arn

  ses_topic_name = var.ses_topic_name
  providers = {
    aws = aws.primary
  }
}