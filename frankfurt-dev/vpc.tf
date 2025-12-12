// creating vpc 1

resource "aws_vpc" "main" {
  cidr_block = var.gives_cidr_to_vpc

  tags = {
    Name = "frankfurt-vpc"
  }

  # provider = aws.eu-central-1  # Uncomment if you have a specific provider configuration

}


