variable subnet_ids {
    type = list(string)
    #default = ["subnet-0195ba4a1e9e08640","subnet-0e8f6c54f3f93388f"]
}
variable "security_groups" {
  type = list(string)
  default = []  
}