output "dns" {
  value = module.alb.dns
}

output "bastion_ip" {
  value = aws_instance.bastion.public_ip
}