variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ssh_key_name" {
  type    = string
  default = ""
}

variable "cidr_whitelist" {
  type = list(string)
}

variable "extra_whitelisted_ingress_rules" {
  type = list(object({
    ip_protocol = optional(string, "tcp")
    from_port   = string
    to_port     = string
  }))

  default = []
}

variable "extra_ingress_rules" {
  type = list(object({
    ip_protocol = optional(string, "tcp")
    from_port   = string
    to_port     = string
    cidr_ipv4   = string
  }))

  default = []
}

variable "allow_web_traffic" {
  type    = bool
  default = false
}

variable "allow_ssh" {
  type    = bool
  default = true
}
