provider "aws" {
  access_key = "XXXXXXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXX"
  region     = "ap-southeast-1"
}

resource "aws_instance" "firstec2" {
  ami           = "ami-03faaf9cde2b38e9f"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow-SSH.id]
  tags = {
     Name = "terraform-instance-first"
  }
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install httpd -y
              echo "This is the first EC2 instance" > /var/www/html/index.html
              service httpd start
              EOF
}

resource "aws_security_group" "allow-SSH" {
  name        = "allow-SSH"
  description = "Allow SSH inbound traffic"
 #Inbound HTTP from anywhere
  
  ingress {
    # SSH Port 22 allowed from any IP
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    # SSH Port 80 allowed from any IP
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow HTTPD"
  }
}

output "public_ip" {
  value = aws_instance.firstec2.public_ip
  description = "this is public ip of the ec2instance"
  #sensitive = true
}
output "id" {
  value = aws_instance.firstec2.id
  description = "this is id of the ec2instance"
}
output "public_dns" {
  value = aws_instance.firstec2.public_dns
  description = "this is public dns of the ec2instance"
}
output "instance_type" {
  value = aws_instance.firstec2.instance_type
  description = "this is instance type of the ec2instance"
}
output "availability_zone" {
  value = aws_instance.firstec2.availability_zone
  description = "this is availability_zone of the ec2instance"
}
