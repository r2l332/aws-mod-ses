locals {
  # some ses resources don't allow for the terminating '.' in the domain name
  # so use a replace function to strip it out
  stripped_domain_name = replace(var.domain, "/[.]$/", "")
}

# SES Domain Verify
resource "aws_ses_domain_identity" "ses_verify_domain" {
  domain = local.stripped_domain_name
}

resource "aws_ses_domain_dkim" "ses_dkim" {
  domain = aws_ses_domain_identity.ses_verify_domain.domain
}

# This will need manual verification 
# resource "aws_ses_domain_identity_verification" "ses_verify" {
#   count      = var.enable_verification ? 1 : 0
#   domain     = aws_ses_domain_identity.ses_verify_domain.id
#   depends_on = [aws_route53_record.verify_txt_alt]
# }

# SES Email Received Rule
resource "aws_ses_receipt_rule_set" "ses_rule_set_name" {
  rule_set_name = var.rule_set_name
}

resource "aws_ses_receipt_rule" "ses_rule" {
  name          = var.rule_name
  rule_set_name = var.rule_set_name
  enabled       = true
  recipients    = ["tlz-account@${var.domain}", "abc-account@${var.domain}"]
  scan_enabled  = true

  sns_action {
    topic_arn = aws_sns_topic.sns_ses_topic.arn
    position  = 1
  }
}

resource "aws_ses_email_identity" "dl_verify" {
  email = var.dl_email_address
}

resource "aws_ses_email_identity" "sender_verify" {
  email = "tlz-account@${var.domain}"
}

resource "aws_ses_active_receipt_rule_set" "ses_rule_set" {
  rule_set_name = var.rule_set_name
  depends_on    = [aws_ses_receipt_rule_set.ses_rule_set_name]
}

# SNS Topic Lambda Trigger
resource "aws_sns_topic" "sns_ses_topic" {
  name = var.ses_topic_name
}

resource "aws_sns_topic_subscription" "sns_topic" {
  topic_arn = aws_sns_topic.sns_ses_topic.arn
  protocol  = "lambda"
  endpoint  = var.ses_lambda_arn
}