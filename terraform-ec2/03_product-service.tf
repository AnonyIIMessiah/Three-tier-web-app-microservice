locals {
  product-name = "product-service"
}
module "sg-product" {
  source    = "./modules/security-group"
  name      = "${local.product-name}-sg"
  from_port = 5002
  to_port   = 5002
}

module "lt-product" {
  source           = "./modules/launch_template"
  name             = "lt-${local.product-name}"
  instance_profile = aws_iam_instance_profile.instance-profile.name
  security_groups  = [module.sg-product.sg_id]
  #   user_data = filebase64("${path.module}/example.sh")

}


# module "targer_group_and_listener-product" {
#   source       = "./modules/target_group_and_listener"
#   name         = local.product-name
#   lb_arn       = module.alb.lb_arn
#   vpc_id       = var.vpc_id
#   path_pattern = "/products"
#   priority     = 2
# }


module "asg-product" {
  source              = "./modules/asg"
  asg_name            = "${local.product-name}-asg"
  vpc_zone_subnets    = [var.subnet_ids[2]]
  launch_template_id  = module.lt-product.template_id
  aws_lb_target_group = [resource.aws_lb_target_group.product.arn]

}

# target groups


resource "aws_lb_target_group" "product" {
  name = "${local.product-name}-tg"
  #   target_type = "alb"
  port     = 5002
  protocol = "HTTP"
  vpc_id   = var.vpc_id #data.aws_vpc.selected.id
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

resource "aws_lb_listener" "product" {

  load_balancer_arn = module.alb.lb_arn #aws_lb.webapp-alb.arn
  port              = 5002
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.product.id
    type             = "forward"
  }
}


resource "aws_lb_listener_rule" "product" {
  listener_arn = aws_lb_listener.product.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.product.arn
  }

  condition {
    path_pattern {
      values = ["/products"]
    }
  }


}
