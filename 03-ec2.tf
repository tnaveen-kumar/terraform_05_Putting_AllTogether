resource "aws_instance" "myec2-1" {
    ami = var.ami_id
    instance_type = var.Instance_type
    availability_zone = var.Az_location
    key_name = var.kp
    subnet_id = aws_subnet.Dev_Public_Subnet.id
    #security_groups = [aws_security_group.public_sg.name]
    user_data = file("install_httpd.sh")
    tags = {
    Name = "${var.env_code}-VM-Public"
  }
}

/*
resource "aws_instance" "myec2-2" {
    ami = var.ami_id
    instance_type = var.Instance_type
    availability_zone = var.Az_location
    key_name = var.kp
    subnet_id = aws_subnet.Dev_Private_Subnet.id
    tags = {
    Name = "${var.env_code}-VM-Private"
  }
}
*/

output "Site-Url" {
  value = aws_instance.myec2-1.public_ip
}