variable "REGION" {
  default = "us-east-1"

}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-2 = "ami-05fb0b8c1424f266b"
    us-east-1 = "ami-079db87dc4c10ac91"

  }
}

variable "USER" {
  default = "ec2-user"
}

