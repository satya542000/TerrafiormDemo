resource "aws_subnet" "subnets" {
  for_each          = var.my_subnets_vars
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  tags              = each.value["tags"]
  depends_on = [
    aws_vpc.my_vpc
  ]
}