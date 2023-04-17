

# Create a new VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = var.tags
}

# Create an internet gateway and attach it to the VPC
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-igw"
  }
  depends_on = [
    aws_vpc.my_vpc
  ]
}

# # Create a default route table and associate it with the VPC
resource "aws_default_route_table" "my_rt" {
  default_route_table_id = aws_vpc.my_vpc.default_route_table_id
  route {
    cidr_block = var.igw_cidr
    gateway_id = aws_internet_gateway.my_igw.id
  }
}


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
resource "aws_route_table_association" "my_rta" {

  subnet_id      = [for n in aws_subnet.subnets : n.id if n.tags.Name == "subnet-1"][0]
  route_table_id = aws_default_route_table.my_rt.id
}
resource "aws_security_group" "my_security_group" {
  name_prefix = var.sg_name
  vpc_id      = aws_vpc.my_vpc.id

  dynamic "ingress" {

    for_each = var.ingress_rules
    content {
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      description      = lookup(ingress.value, "description", null)
      cidr_blocks      = lookup(ingress.value, "cidr_blocks", null)
      ipv6_cidr_blocks = lookup(ingress.value, "ipv6_cidr_blocks", null)
      prefix_list_ids  = lookup(ingress.value, "prefix_list_ids", null)
      security_groups  = lookup(ingress.value, "security_groups", null)
      self             = lookup(ingress.value, "self", null)
    }
  }
  depends_on = [
    aws_vpc.my_vpc
  ]
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = var.my-key-pair
  public_key = file(var.keypair_file_path)
}
  




resource "aws_instance" "my_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.my_security_group.id]
  associate_public_ip_address = true
  subnet_id                   = [for n in aws_subnet.subnets : n.id if n.tags.Name == "subnet-1"][0]
  depends_on = [
    aws_security_group.my_security_group,
    aws_subnet.subnets
  ]
}

