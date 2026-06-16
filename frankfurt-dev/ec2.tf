data "aws_ami" "amazon_linux_2023" {
    most_recent = true
    owners      = ["amazon"]  # Amazon's official AMIs

    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]  # Adjust the filter to match your requirements
    }
    filter {
        name   = "architecture"
        values = ["x86_64"]  # Adjust if you need a different architecture
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]  # Ensure the AMI is HVM type
    }
    filter {
        name   = "state"
        values = ["available"]  # Ensure the AMI is available
    }
    filter {
        name   = "root-device-type"
        values = ["ebs"]  # Ensure the AMI uses EBS as the root device
    }
    filter {
        name   = "image-type"
        values = ["machine"]  # Ensure the AMI is a machine image
    }
    filter {
        name   = "owner-alias"
        values = ["amazon"]  # Ensure the AMI is owned by Amazon
    }
    filter {
        name   = "platform-details"
        values = ["Linux/UNIX"]  # Ensure the AMI is for Linux/UNIX
    }
}

// Create a security group for the EC2 instance
resource "aws_security_group" "ec2_sg" {
  name        = "frankfurt-ec2-sg"
  description = "Security group for Frankfurt EC2 instance"
  // create a key pair for SSH access

  vpc_id      = aws_vpc.main.id

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

  # Allow ICMP (ping) from other VPCs
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["31.0.0.0/16", "41.0.0.0/16", "51.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "frankfurt-ec2-sg"
    env  = "development"
  }
}

// Create EC2 instance in first public subnet
resource "aws_instance" "frankfurt_ec2" {
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
              echo "<h1>Frankfurt Development Server</h1>" > /var/www/html/index.html
              echo "<p>Region: eu-central-1</p>" >> /var/www/html/index.html
              echo "<p>Environment: Development</p>" >> /var/www/html/index.html
              EOF

  tags = {
    Name = "frankfurt-dev-server"
    env  = "development"
  }
}