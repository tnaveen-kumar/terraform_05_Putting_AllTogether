resource "aws_vpc" "Dev_VPC" {
  cidr_block       = var.vpc_cidr_range
  instance_tenancy = "default"
  
  tags = {
    Name = "${var.env_code}-TF-VPC"
  }
}

resource "aws_internet_gateway" "Dev_IGW" {
  vpc_id = aws_vpc.Dev_VPC.id

  tags = {
    Name = "${var.env_code}-TF-IGW"
  }
}

resource "aws_subnet" "Dev_Public_Subnet" {
  vpc_id     = aws_vpc.Dev_VPC.id
  cidr_block = var.public_subnet_cidr_range
  availability_zone =var.Az_location
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env_code}-Public-Subnet"
  }
}

resource "aws_subnet" "Dev_Private_Subnet" {
  vpc_id     = aws_vpc.Dev_VPC.id
  cidr_block = var.private_subnet_cidr_range
  availability_zone =var.Az_location
  tags = {
    Name = "${var.env_code}-Private-Subnet"
  }
}

resource "aws_route_table" "Dev_public_route_table" {
  vpc_id = aws_vpc.Dev_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Dev_IGW.id
  }
  tags = {
    Name = "${var.env_code}-Public-RT"
  }
}


resource "aws_route_table_association" "Dev_public_subnet_association" {
  subnet_id      = aws_subnet.Dev_Public_Subnet.id
  route_table_id = aws_route_table.Dev_public_route_table.id
}


resource "aws_route_table" "Dev_private_route_table" {
  vpc_id = aws_vpc.Dev_VPC.id
  tags = {
    Name = "${var.env_code}-Private-RT"
  }
}

resource "aws_route_table_association" "Dev_private_subnet_association" {
  subnet_id      = aws_subnet.Dev_Private_Subnet.id
  route_table_id = aws_route_table.Dev_private_route_table.id
}