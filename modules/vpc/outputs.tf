output "vpc_id" {
  value = aws_vpc.stas_vpc.id
}

output "subnet_ids" {
  value = {
    subnet1 = aws_subnet.stas_subnet1.id
    subnet2 = aws_subnet.stas_subnet2.id
  }
}

output "internet_gateway_id" {
  value = aws_internet_gateway.stas_internet_gateway.id
}
