resource "aws_key_pair" "terr_key" {
  key_name   = "ter_inst_key"
  public_key = file("dove.pub")
}

resource "aws_instance" "auto_inst_terr" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.terr_key.key_name
  vpc_security_group_ids = ["sg-02c34c09bfa6c387b"]

  tags = {
    Name    = "terr_web_prov_07"
    Project = "terraform_learning_07"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh || echo 'Script failed: $?'"
    ]
  }

  connection {
    type        = "ssh"
    user        = var.USER
    private_key = file("dove")
    host        = self.public_ip
  }
}

output "PublicIP" {
  value = aws_instance.auto_inst_terr.public_ip
}

output "PrivateIP" {
  value = aws_instance.auto_inst_terr.private_ip
}
