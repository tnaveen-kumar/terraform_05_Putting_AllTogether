resource "aws_security_group" "public_sg" {
  name        = "${var.env_code}_sg"
  vpc_id = aws_vpc.Dev_VPC.id

  // Define ingress rules (inbound traffic)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  // Define egress rules (outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  
    cidr_blocks = ["0.0.0.0/0"]
  }
}