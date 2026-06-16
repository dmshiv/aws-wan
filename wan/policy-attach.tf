// VPC attachments should be created in each regional folder, not here in WAN
// The WAN folder only creates the core network infrastructure
// Each regional folder will create its own VPC attachment after the core network exists

/*
// This file has been moved to regional folders
// Each regional folder will create its own attachment like this:

resource "aws_networkmanager_vpc_attachment" "regional_vpc_attachment" {
  core_network_id = data.terraform_remote_state.wan.outputs.core_network_id
  vpc_arn         = aws_vpc.main.arn
  subnet_arns     = [
    aws_subnet.public_subnet_1.arn,
    aws_subnet.public_subnet_2.arn,
    aws_subnet.public_subnet_3.arn
  ]
  tags = {
    env = "development/production/shared"
    Name = "vpc-attachment-{region}"
  }
}
*/

