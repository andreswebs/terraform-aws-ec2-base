# terraform-aws-ec2-base

Infrastructure dependencies for an EC2 instansce.

[//]: # (BEGIN_TF_DOCS)


## Usage

Example:

```hcl
module "ec2_base" {
  source         = "github.com/andreswebs/terraform-aws-ec2-base"
  vpc_id         = var.vpc_id
  cidr_whitelist = var.cidr_whitelist
  name           = "k3s"

  allow_web_traffic = true

  extra_whitelisted_ingress_rules = [
    {
      from_port = "6443"
      to_port   = "6443"
    }
  ]

}
```



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_ssh"></a> [allow\_ssh](#input\_allow\_ssh) | n/a | `bool` | `true` | no |
| <a name="input_allow_web_traffic"></a> [allow\_web\_traffic](#input\_allow\_web\_traffic) | n/a | `bool` | `false` | no |
| <a name="input_cidr_whitelist"></a> [cidr\_whitelist](#input\_cidr\_whitelist) | n/a | `list(string)` | `[]` | no |
| <a name="input_extra_ingress_rules"></a> [extra\_ingress\_rules](#input\_extra\_ingress\_rules) | n/a | <pre>list(object({<br>    ip_protocol = optional(string, "tcp")<br>    from_port   = string<br>    to_port     = string<br>    cidr_ipv4   = string<br>  }))</pre> | `[]` | no |
| <a name="input_extra_whitelisted_ingress_rules"></a> [extra\_whitelisted\_ingress\_rules](#input\_extra\_whitelisted\_ingress\_rules) | n/a | <pre>list(object({<br>    ip_protocol = optional(string, "tcp")<br>    from_port   = string<br>    to_port     = string<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | n/a | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_keypair"></a> [ec2\_keypair](#module\_ec2\_keypair) | andreswebs/insecure-ec2-key-pair/aws | 1.0.0 |
| <a name="module_ec2_role"></a> [ec2\_role](#module\_ec2\_role) | andreswebs/ec2-role/aws | 1.1.0 |
| <a name="module_s3_requisites_for_ssm"></a> [s3\_requisites\_for\_ssm](#module\_s3\_requisites\_for\_ssm) | andreswebs/s3-requisites-for-ssm-policy-document/aws | 1.1.0 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_profile"></a> [instance\_profile](#output\_instance\_profile) | n/a |
| <a name="output_instance_role"></a> [instance\_role](#output\_instance\_role) | n/a |
| <a name="output_key_pair"></a> [key\_pair](#output\_key\_pair) | n/a |
| <a name="output_security_group"></a> [security\_group](#output\_security\_group) | n/a |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role_policy.s3_requisites_for_ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.open_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.open_ipv6](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.extra_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.extra_whitelisted_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |

[//]: # (END_TF_DOCS)

## Authors

**Andre Silva** - [@andreswebs](https://github.com/andreswebs)

## License

This project is licensed under the [Unlicense](UNLICENSE.md).
