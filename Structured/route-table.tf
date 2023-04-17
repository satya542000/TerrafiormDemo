resource "aws_default_route_table" "my_rt" {
  default_route_table_id = aws_vpc.my_vpc.default_route_table_id
  route {
    cidr_block = var.igw_cidr
    gateway_id = aws_internet_gateway.my_igw.id
  }
  depends_on = [
    aws_internet_gateway.my_igw
  ]
}
resource "aws_route_table_association" "my_rta" {

  subnet_id      = [for n in aws_subnet.subnets : n.id if n.tags.Name == "subnet-1"][0]
  route_table_id = aws_default_route_table.my_rt.id
}