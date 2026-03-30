provider "aws" {
  region = "us-east-2"
} 
resource "aws_instance" "web1" {
  ami           = "ami-0b0b78dcacbab728f"  # Amazon Linux 2 AMI
  instance_type = "t3.micro"
  key_name               = "my-key"       
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = {
    Name = "WebServer1"
  }
}

resource "aws_instance" "web2" {
  ami           = "ami-0b0b78dcacbab728f"
  instance_type = "t3.micro"
  key_name               = "my-key"        
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = {
    Name = "WebServer2"
  }
}

resource "aws_instance" "web3" {
  ami           = "ami-0b0b78dcacbab728f"
  instance_type = "t3.micro"
  key_name               = "my-key"        
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = {
    Name = "WebServer3"
  }
}

# --- New control server ---
resource "aws_instance" "control" {
  ami                    = "ami-0b0b78dcacbab728f"
  instance_type          = "t3.micro"
  key_name               = "my-key"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = { Name = "ControlServer" }
}

# --- Security group (allows SSH and HTTP) ---
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # allows SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # allows HTTP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # allows all outbound
  }
}

# --- Outputs so you can see the IPs after apply ---
output "web1_ip" { value = aws_instance.web1.public_ip }
output "web2_ip" { value = aws_instance.web2.public_ip }
output "web3_ip" { value = aws_instance.web3.public_ip }
output "control_ip" { value = aws_instance.control.public_ip }