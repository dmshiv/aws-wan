data "aws_ami" "amazon_linux_2023" {
    most_recent = true
    owners      = ["amazon"]  # Amazon's official AMIs

    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
    filter {
        name   = "architecture"
        values = ["x86_64"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    filter {
        name   = "state"
        values = ["available"]
    }
    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }
    filter {
        name   = "image-type"
        values = ["machine"]
    }
    filter {
        name   = "owner-alias"
        values = ["amazon"]
    }
    filter {
        name   = "platform-details"
        values = ["Linux/UNIX"]
    }
}

// Create a security group for the EC2 instance
resource "aws_security_group" "ec2_sg" {
  name        = "stockholm-ec2-sg"
  description = "Security group for Stockholm EC2 instance"
  vpc_id      = aws_vpc.create_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "stockholm-ec2-sg"
    env  = "production"
  }
}

// Create EC2 instance in first public subnet
resource "aws_instance" "stockholm_ec2" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_subnet[0].id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = "my-ec2-key"
  
  associate_public_ip_address = true
  
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Stockholm Production Server</h1>" > /var/www/html/index.html
              echo "<p>Region: eu-north-1</p>" >> /var/www/html/index.html
              echo "<p>Environment: Production</p>" >> /var/www/html/index.html
              EOF

  tags = {
    Name = "stockholm-prod-server"
    env  = "production"
  }
}