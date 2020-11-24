provider "aws" {
  access_key = "XXXXXXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXX"
  region = var.region
}

resource "aws_instance" "Tiger Dev EC2" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow-SSH.id]
  tags = {
     Name = "Tiger Dev Instance"
  }
}

resource "aws_security_group" "allow-SSH" {
  name        = "allow-SSH"
  description = "Allow SSH inbound traffic"
 
 #Inbound HTTP from anywhere  
  ingress {
    # SSH Port 22 allowed from any IP
    from_port   = var.web-server-port
    to_port     = var.web-server-port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}