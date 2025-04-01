locals {
  user-name = "user-service"
}
module "sg-user" {
  source    = "./modules/security-group"
  name      = "${local.user-name}-sg-user"
  from_port = 5001
  to_port   = 5001
}

module "lt-user" {
  source           = "./modules/launch_template"
  name             = "lt-${local.user-name}"
  instance_profile = aws_iam_instance_profile.instance-profile.name
  security_groups  = [module.sg-user.sg_id]
  #   user_data = filebase64("${path.module}/example.sh")

}


# module "targer_group_and_listener-user" {
#   source       = "./modules/target_group_and_listener"
#   name         = local.user-name
#   lb_arn       = module.alb.lb_arn
#   vpc_id       = var.vpc_id
#   path_pattern = "/users"
#   priority     = 2
# }


module "asg-user" {
  source              = "./modules/asg"
  asg_name            = "${local.user-name}-asg"
  vpc_zone_subnets    = [var.subnet_ids[2]]
  launch_template_id  = module.lt-user.template_id
  aws_lb_target_group = [resource.aws_lb_target_group.user.arn]

}

#target groups

resource "aws_lb_target_group" "user" {
  name = "${local.user-name}-tg"
  #   target_type = "alb"
  port     = 5001
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

resource "aws_lb_listener" "user" {

  load_balancer_arn = module.alb.lb_arn #aws_lb.webapp-alb.arn
  port              = 5001
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.user.id
    type             = "forward"
  }
}


resource "aws_lb_listener_rule" "user" {
  listener_arn = aws_lb_listener.user.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.user.arn
  }

  condition {
    path_pattern {
      values = ["/users"]
    }
  }


}
