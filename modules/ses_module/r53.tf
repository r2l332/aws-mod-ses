# Domain Configuration
resource "aws_route53_zone" "ses_domain" {
  name    = var.domain
  comment = "SES module domain"
}


# DNS Record Creation
resource "aws_route53_record" "verify_txt_alt" {
  zone_id    = aws_route53_zone.ses_domain.zone_id
  name       = "_amazonses"
  type       = "TXT"
  ttl        = "600"
  records    = [aws_ses_domain_identity.ses_verify_domain.verification_token]
  depends_on = [aws_route53_zone.ses_domain]
}

resource "aws_route53_record" "ses_dkim" {
  count   = 3
  zone_id = aws_route53_zone.ses_domain.zone_id
  name = format(
    "%s._domainkey.%s",
    element(aws_ses_domain_dkim.ses_dkim.dkim_tokens, count.index),
    var.domain,
  )
  type       = "CNAME"
  ttl        = "600"
  records    = ["${element(aws_ses_domain_dkim.ses_dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
  depends_on = [aws_route53_zone.ses_domain]
}

resource "aws_route53_record" "ses_mx_receive" {
  count      = 1
  name       = var.domain
  zone_id    = aws_route53_zone.ses_domain.zone_id
  type       = "MX"
  ttl        = "600"
  records    = ["10 inbound-smtp.${var.ses_region}.amazonaws.com"]
  depends_on = [aws_route53_zone.ses_domain]
}

