resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-igw"
  }
  depends_on = [
    aws_vpc.my_vpc
  ]
}