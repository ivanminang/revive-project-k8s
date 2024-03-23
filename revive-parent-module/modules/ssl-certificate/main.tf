resource "aws_acm_certificate" "revive" {
  # provider = aws.acm
  domain_name       = "camerspeed.com"
  # domain_name       = "reviceapp.com"
  subject_alternative_names = ["*.camerspeed.com"]
  # subject_alternative_names = ["*.reviceapp.com"]
  validation_method = "DNS"

  tags = {
  "id"               = "2024"
    "owner"          = "Devops Easy Learning"
    "teams"          = "Phase-10-1"
    # "environment"    = "Prod"
    "project"        = "revive"
    "create_by"      = "EK-TECH Solutions"
    "cloud_provider" = "aws"
    "terraform"      = "true"
}

  lifecycle {
    create_before_destroy = true
  }
}

# data source to retrieve the name of the hosted zone to contain the record
data "aws_route53_zone" "hostedzone" {

  # name         = "reviceapp.com"
  name         = "camerspeed.com"
  private_zone = false
}

# creation of DNS Record for certificate validation
resource "aws_route53_record" "cert_validation" {
  name    = tolist(aws_acm_certificate.revive.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.revive.domain_validation_options)[0].resource_record_type
  zone_id = "${data.aws_route53_zone.hostedzone.id}"
  records = [tolist(aws_acm_certificate.revive.domain_validation_options)[0].resource_record_value]
  ttl     = 60
}

# Validation of certificate
resource "aws_acm_certificate_validation" "revive" {
  # provider = aws.acm
  certificate_arn         = "${aws_acm_certificate.revive.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
}

# Creation of DNS Alias Record for our subdomain name pointint to our ELB endpoint
# resource "aws_route53_record" "revive" {
#   zone_id = data.aws_route53_zone.hostedzone.zone_id
#   name    = "del.camerspeed.com"
#   type    = "A"

#   alias {
#     name                   = aws_lb.terra.dns_name
#     zone_id                = aws_lb.terra.zone_id
#     evaluate_target_health = true
#   }
# }