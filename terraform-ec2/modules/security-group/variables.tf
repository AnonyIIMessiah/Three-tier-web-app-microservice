variable "from_port" {
  type = number
  default = 80 
}

variable "to_port" {
  type = number
  default = 80 
  
}

variable "name" {
  type = string
  default = "temp-security-group"
  
}