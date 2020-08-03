data "aws_route53_zone" "tlz_domain" {
  name = "${var.domain}."
}