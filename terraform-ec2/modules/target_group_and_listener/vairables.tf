variable "name" {
  description = "Name of the target group"
  type        = string  
}

variable "port" {
  description = "Port of the target group"
  type        = number
  default     = 80
}

variable "lb_arn" {
  description = "Load balancer ARN"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  
}

variable "path_pattern" {
  description = "Path pattern for the listener rule"
  type        = string
  default     = "/*"  
}

variable "priority" {
  description = "Priority for the listener rule"
  type        = number
  default     = 1
  
}