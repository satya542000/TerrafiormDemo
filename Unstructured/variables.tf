
variable "my_subnets_vars" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  }))
}
variable "ingress_rules" {
  type = list(any)

}
variable "vpc_cidr_block" {
  type = string
}
variable "igw_cidr" {
  type = string
}
variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "my-key-pair" {
  type = string
}
variable "keypair_file_path" {
  type = string
}
variable "sg_name" {
  type = string
}
variable "bucket_name" {
  type    = string
  default = "my-s3-backend-bucket-for-statefile"
}
variable "bucket_key" {
  type    = string
  default = "my-terraform-state-file"
}
variable "tags"{
  type=map(any)
  default= {
    Name = "my-vpc"
  }
  
}