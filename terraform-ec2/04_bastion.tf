module "security_group" {
  source    = "./modules/security-group"
  name      = "bastion-host-sg"
  from_port = 80
  to_port   = 80
}
resource "aws_instance" "bastion" {
  ami                    = "ami-076c6dbba59aa92e6"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-0195ba4a1e9e08640"
  vpc_security_group_ids = [module.security_group.sg_id]
  key_name               = "temp-key"
  tags = {
    Name = "bastion_host"
  }
}