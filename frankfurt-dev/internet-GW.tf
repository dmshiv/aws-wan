//3 creating internet gateway
resource "aws_internet_gateway" "create_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "frankfurt-igw-pub"
  }

  # provider = aws.eu-central-1  # Uncomment if you have a specific provider configuration

}

