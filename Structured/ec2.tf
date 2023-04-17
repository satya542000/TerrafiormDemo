
resource "aws_key_pair" "my_key_pair" {
  key_name   = var.my-key-pair
  public_key = file(var.keypair_file_path)
}
  
# resource "null_resource" "download_keypair" {
#   depends_on = [
#     aws_key_pair.my_key_pair
#   ]
#    provisioner "file" {
#     content     = aws_key_pair.my_key_pair.private_key_pem
#     destination = "my-key_pair.pem"
#   }
# }



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
