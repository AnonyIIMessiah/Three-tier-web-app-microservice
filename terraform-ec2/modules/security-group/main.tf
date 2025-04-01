
resource "aws_security_group" "terraform-sg" {
  name = var.name

  ingress = [
    {
      description      = "Allow HTTP"
      from_port        = var.from_port
      to_port          = var.to_port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"] # FIX: Allow public access
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },

    {
      description      = "Allow SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"] # FIX: Allow public access
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "Allow all outbound traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"] # FIX: Allow all outbound traffic
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = var.name
  }
}

