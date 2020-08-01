resource "aws_route53_record" "tlz_subdomain" {
  count   = 1
  name    = var.domain
  zone_id = data.aws_route53_zone.tlz_domain.zone_id
  type    = "NS"
  ttl     = "30"
  records = module.ses_infra.route_53_nameservers
}