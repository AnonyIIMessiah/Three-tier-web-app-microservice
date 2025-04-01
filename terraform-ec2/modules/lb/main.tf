resource "aws_lb" "webapp-alb" {
  name                       = "microservice-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = var.security_groups #[aws_security_group.terraform-sg.id]
  subnets                    = var.subnet_ids
  enable_deletion_protection = false


  tags = {
    Environment = "production"
  }
}