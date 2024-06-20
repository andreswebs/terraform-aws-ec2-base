
module "ec2_base" {
  source              = "../"
  vpc_id              = var.vpc_id
  cidr_whitelist_ipv4 = var.cidr_whitelist_ipv4
  name                = "k3s"

  allow_web_traffic = true

  extra_whitelisted_ingress_rules = [
    {
      from_port = "6443"
      to_port   = "6443"
    }
  ]

}
