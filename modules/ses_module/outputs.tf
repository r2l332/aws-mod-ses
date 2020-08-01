output "route_53_nameservers" {
  value = aws_route53_zone.ses_domain.name_servers
}

output "dl_ses_topic_arn" {
  value = aws_sns_topic.sns_ses_topic.arn
}
