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