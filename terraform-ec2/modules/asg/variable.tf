variable "asg_name" {
  description = "Name of the ASG"
  type        = string
  default     = "webapp-asg"      
}

variable "vpc_zone_subnets" {
  description = "values of the subnets"
  type        = list(string)
}

variable "launch_template_id" {
  description = "ID of the launch template"
  type        = string 
}

variable "aws_lb_target_group" {
  type = list(string)
}