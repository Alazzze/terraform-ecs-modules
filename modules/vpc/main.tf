provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "stas_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "stas-vpc"
  }
}

resource "aws_subnet" "stas_subnet1" {
  vpc_id            = aws_vpc.stas_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "stas-subnet1"
  }
}

resource "aws_subnet" "stas_subnet2" {
  vpc_id            = aws_vpc.stas_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "stas-subnet2"
  }
}

resource "aws_internet_gateway" "stas_internet_gateway" {
  vpc_id = aws_vpc.stas_vpc.id

  tags = {
    Name = "stas-internet-gateway"
  }
}

resource "aws_route_table" "stas_route_table" {
  vpc_id = aws_vpc.stas_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.stas_internet_gateway.id
  }

  tags = {
    Name = "stas-route-table"
  }
}

resource "aws_route_table_association" "stas_route_table_association1" {
  subnet_id      = aws_subnet.stas_subnet1.id
  route_table_id = aws_route_table.stas_route_table.id
}

resource "aws_route_table_association" "stas_route_table_association2" {
  subnet_id      = aws_subnet.stas_subnet2.id
  route_table_id = aws_route_table.stas_route_table.id
}

