locals {
  name = "frontend"
}
module "sg" {
  source    = "./modules/security-group"
  name      = "${local.name}-sg"
  from_port = 80
  to_port   = 80
}

module "lt" {
  source           = "./modules/launch_template"
  name             = "frontend"
  instance_profile = aws_iam_instance_profile.instance-profile.name
  security_groups  = [module.sg.sg_id]
  # user_data = filebase64("${path.module}/example.sh")

}


# module "targer_group_and_listener" {
#   source       = "./modules/target_group_and_listener"
#   name         = local.name
#   lb_arn       = module.alb.lb_arn
#   vpc_id       = var.vpc_id
#   path_pattern = "/"
#   priority     = 1
# }


module "asg" {
  source              = "./modules/asg"
  asg_name            = "${local.name}-asg"
  vpc_zone_subnets    = [var.subnet_ids[2]]
  launch_template_id  = module.lt.template_id
  aws_lb_target_group = [resource.aws_lb_target_group.frontend.arn]

}

#target groups

resource "aws_lb_target_group" "frontend" {
  name = "${local.name}-tg-1"
  #   target_type = "alb"
  port     = 80
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

resource "aws_lb_listener" "frontend" {

  load_balancer_arn = module.alb.lb_arn #aws_lb.webapp-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.frontend.id
    type             = "forward"
  }
}


resource "aws_lb_listener_rule" "frontend" {
  listener_arn = aws_lb_listener.frontend.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }


}
