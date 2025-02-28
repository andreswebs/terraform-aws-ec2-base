variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ssh_key_name" {
  type    = string
  default = null
}

variable "create_ssh_key" {
  type    = bool
  default = false
}

variable "cidr_whitelist_ipv4" {
  type    = list(string)
  default = []
}

variable "extra_whitelisted_ingress_rules_ipv4" {
  type = list(object({
    ip_protocol = optional(string, "tcp")
    from_port   = string
    to_port     = string
  }))

  default = []
}

variable "extra_ingress_rules_ipv4" {
  type = list(object({
    ip_protocol                  = optional(string, "tcp")
    from_port                    = string
    to_port                      = string
    cidr_ipv4                    = optional(string)
    referenced_security_group_id = optional(string)
  }))

  default = []
}

variable "allow_public_web_traffic" {
  type    = bool
  default = false
}

variable "allow_ssh" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
