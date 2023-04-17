
my_subnets_vars = {
  "1" = {
    availability_zone = "us-east-1a"
    cidr_block        = "10.0.0.0/24"
    tags = {
      "Name" = "subnet-1"
    }
  }
  "2" = {
    availability_zone = "us-east-1b"
    cidr_block        = "10.0.1.0/24"
    tags = {
      "Name" = "subnet-2"
    }
  }
}
ingress_rules = [
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
vpc_cidr_block    = "10.0.0.0/16"
igw_cidr          = "0.0.0.0/0"
ami               = "ami-007855ac798b5175e"
instance_type     = "t2.micro"
my-key-pair       = "my-key-pair"
keypair_file_path = "~/.ssh/id_rsa.pub"
sg_name           = "my-security-group"