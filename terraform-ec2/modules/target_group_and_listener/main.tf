resource "aws_lb_target_group" "webapp" {
  name        = "${var.name}-tg"
#   target_type = "alb"
  port        = var.port
  protocol    = "HTTP"
    vpc_id      = var.vpc_id #data.aws_vpc.selected.id
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

resource "aws_lb_listener" "webapp" {
  
  load_balancer_arn = var.lb_arn #aws_lb.webapp-alb.arn
  port              = var.port
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.webapp.id
    type             = "forward"
  }
}


resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_lb_listener.webapp.arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp.arn
  }

  condition {
    path_pattern {
      values = [var.path_pattern]
    }
  }


}
