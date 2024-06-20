output "key_pair" {
  value = var.create_ssh_key ? module.ec2_keypair[0].key_pair : null
}

output "instance_role" {
  value = module.ec2_role.role
}

output "instance_profile" {
  value = module.ec2_role.instance_profile
}

output "security_group" {
  value = aws_security_group.this
}
