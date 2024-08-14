
provider "aws" {
  region = "us-east-2"
}

provider "random" {}

resource "random_pet" "name" {}

resource "aws_instance" "example" {
  ami           =  "ami-0fb653ca2d3203ac1" 
  instance_type = "t2.micro"
  key_name = "ssh-pair"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  user_data_replace_on_change = true
  tags = {
    Name = random_pet.name.id
  }
}

resource "aws_security_group" "web" {
  name = "terraform-example-web"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name = "ssh-pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgPIfY6OysdfMxhrlMJ/5tfDsZrJ/IUcdUOqpxXJ18AMBIjSpWlWnifuTTAWWEvB53ZOJczTiXTA59s+/JwL6bJdP80kEM9KykYzLpaQ+zomkfou1BLXbDR3A6UGA0/NFxoNlPZqeGcgYtFzHiutQjwygNxxvD2C5pGtzlulasGGZ58RkDYsiELdpS6E6VMXAxAqmSEeWpHmwFUkQ3Vwvzf5Lv11HkaMRKRqkEDgD6Y2l8NpyD2cMGVG57tQKSMrKYEsG3FjsksdE3GdUJNmbc8FfpGctedAA3mkWhhEc+2rf3xhniA2MtYGW3CTNi8dvMiqFYSz2tbO/o8xvwKCQH admin@DESKTOP-9ICER92"
}
