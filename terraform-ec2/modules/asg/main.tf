# This file contains the definition of the AWS Autoscaling Group resource.
# It includes the configuration for the Autoscaling Group, including its name, size, launch template, target group, and tags.
resource "aws_autoscaling_group" "asg" {
  name             = var.asg_name
  max_size         = 5
  min_size         = 1
  desired_capacity = 1
  vpc_zone_identifier        = var.vpc_zone_subnets
  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }
  

  target_group_arns = var.aws_lb_target_group #[aws_lb_target_group.webapp.arn]
  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }

#   initial_lifecycle_hook {
#     name                 = "foobar"
#     default_result       = "CONTINUE"
#     heartbeat_timeout    = 2000
#     lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

#     notification_metadata = jsonencode({
#       foo = "bar"
#     })

#     notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
#     role_arn                = "arn:aws:iam::123456789012:role/S3Access"
#   }

  tag {
    key                 = "name"
    value               = var.asg_name
    propagate_at_launch = true
  }
}