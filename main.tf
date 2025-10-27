locals {
  ssh_key_name = var.ssh_key_name != "" && var.ssh_key_name != null ? var.ssh_key_name : "${var.name}-ssh"
}

resource "aws_security_group" "this" {
  vpc_id = var.vpc_id
  name   = var.name

  revoke_rules_on_delete = true

  tags = merge(var.tags, {
    Name = var.name
  })
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  for_each = toset([for cidr in var.cidr_whitelist_ipv4 : cidr if var.allow_ssh])

  security_group_id = aws_security_group.this.id

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_ipv4   = each.value

  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  count = var.allow_public_web_traffic ? 1 : 0

  security_group_id = aws_security_group.this.id

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
  cidr_ipv4   = "0.0.0.0/0"

  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  count = var.allow_public_web_traffic ? 1 : 0

  security_group_id = aws_security_group.this.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
  cidr_ipv4   = "0.0.0.0/0"

  tags = var.tags
}

locals {
  extra_whitelisted_ingress_rules_ipv4 = flatten([for rule in var.extra_whitelisted_ingress_rules_ipv4 : [for cidr in var.cidr_whitelist_ipv4 : {
    from_port   = rule.from_port
    to_port     = rule.to_port
    ip_protocol = rule.ip_protocol
    cidr_ipv4   = cidr
  }]])
}

resource "aws_vpc_security_group_ingress_rule" "extra_whitelisted_ipv4" {
  for_each = { for rule in local.extra_whitelisted_ingress_rules_ipv4 : sha256("${rule.ip_protocol}${rule.from_port}${rule.to_port}${rule.cidr_ipv4}") => rule }

  security_group_id = aws_security_group.this.id

  ip_protocol = each.value.ip_protocol
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  cidr_ipv4   = each.value.cidr_ipv4

  tags = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "extra_ipv4" {
  for_each = { for rule in var.extra_ingress_rules_ipv4 : sha256("${rule.ip_protocol}${rule.from_port}${rule.to_port}${rule.cidr_ipv4}") => rule }

  security_group_id = aws_security_group.this.id

  ip_protocol                  = each.value.ip_protocol
  from_port                    = each.value.from_port
  to_port                      = each.value.to_port
  cidr_ipv4                    = each.value.cidr_ipv4
  referenced_security_group_id = each.value.referenced_security_group_id

  tags = var.tags
}

resource "aws_vpc_security_group_egress_rule" "open_ipv4" {
  security_group_id = aws_security_group.this.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  tags              = var.tags
}

resource "aws_vpc_security_group_egress_rule" "open_ipv6" {
  security_group_id = aws_security_group.this.id
  ip_protocol       = "-1"
  cidr_ipv6         = "::/0"

  tags = var.tags
}

module "ec2_keypair" {
  count              = var.create_ssh_key ? 1 : 0
  source             = "andreswebs/insecure-ec2-key-pair/aws"
  version            = "1.3.0"
  key_name           = local.ssh_key_name
  ssm_parameter_name = "/${var.name}/ssh-key"
  tags               = var.tags
}

module "ec2_role" {
  source           = "andreswebs/ec2-role/aws"
  version          = "3.0.0"
  role_name        = var.name
  role_description = var.name
  profile_name     = var.name
  tags             = var.tags
}

module "s3_requisites_for_ssm" {
  source  = "andreswebs/s3-requisites-for-ssm-policy-document/aws"
  version = "1.2.0"
}

resource "aws_iam_role_policy" "s3_requisites_for_ssm" {
  name   = "s3-requisites-for-ssm"
  role   = module.ec2_role.role.name
  policy = module.s3_requisites_for_ssm.json
}
