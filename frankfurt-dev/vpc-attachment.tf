// Create VPC attachment to the core network

resource "aws_networkmanager_vpc_attachment" "frankfurt_vpc_attachment" {
  core_network_id = data.terraform_remote_state.wan.outputs.core_network_id
  vpc_arn         = aws_vpc.main.arn
  
  subnet_arns = [
    aws_subnet.public_subnet[0].arn,
    aws_subnet.public_subnet[1].arn,
    aws_subnet.public_subnet[2].arn
  ]

  tags = {
    env  = "development"
    Name = "frankfurt-dev-vpc-attachment"
  }
}
