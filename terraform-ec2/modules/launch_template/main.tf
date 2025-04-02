
resource "aws_launch_template" "lt" {
  name = var.name


  iam_instance_profile {
    name = var.instance_profile   
 }

  image_id = "ami-076c6dbba59aa92e6"


  instance_type = "t2.micro"


  key_name = "temp-key"

  


  vpc_security_group_ids = var.security_groups #[aws_security_group.terraform-sg.id]
#   network_interfaces {
#     associate_public_ip_address = true

#   }




  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "webapp"
    }
  }

    user_data = filebase64("${path.module}/example.sh")
}