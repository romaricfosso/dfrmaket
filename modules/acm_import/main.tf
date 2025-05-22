# resource "aws_acm_certificate" "imported" {
#   private_key       = file(var.private_key_path)
#   certificate_body  = file(var.cert_body_path)
#   certificate_chain = file(var.cert_chain_path)

#   tags = var.tags
# }
# resource "aws_route53_record" "cert_validation" {
#   name    = var.validation_record_name
#   type    = var.validation_record_type
#   ttl     = 300
#   records = [var.validation_record_value]
#   zone_id = data.aws_route53_zone.this.zone_id
# }

# resource "aws_acm_certificate_validation" "imported_validated" {
#   certificate_arn         = var.certificate_arn
#   validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
# }

