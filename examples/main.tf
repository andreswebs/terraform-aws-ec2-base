module "ec2_base" {
  source         = "github.com/andreswebs/terraform-aws-ec2-base"
  vpc_id         = var.vpc_id
  cidr_whitelist = var.cidr_whitelist
  name           = "k3s"

  allow_web_traffic = true

  extra_ingress_rules = [
    {
      from_port = "6443"
      to_port   = "6443"
    }
  ]

}
