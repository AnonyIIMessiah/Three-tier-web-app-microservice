variable "vpc_id" {
  description = "vpc_id"
  type        = string
}

variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-0195ba4a1e9e08640", "subnet-0f099d49d0dfc80d0", "subnet-0562998f6aace8de0"]
}

# subnet_ids[2] is private subnet