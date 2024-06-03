resource "aws_instance" "myec2-1" {
    ami = var.ami_id
    instance_type = var.Instance_type
    availability_zone = var.Az_location
    key_name = var.kp
    subnet_id = aws_subnet.Dev_Public_Subnet.id
    vpc_security_group_ids = [aws_security_group.public_sg.id]
    user_data = file("install_httpd.sh")
    tags = {
    Name = "${var.env_code}-VM-Public"
  }
}


output "Site-Url" {
  value = "http://${aws_instance.myec2-1.public_ip}"
}
