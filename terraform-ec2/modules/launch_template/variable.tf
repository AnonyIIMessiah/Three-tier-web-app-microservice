variable "name" {
  description = "value of the name tag"
  type = string
}

variable "instance_profile" {
  type = string
  default = "instance-profile"
}

variable "security_groups" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
  default     = []
}