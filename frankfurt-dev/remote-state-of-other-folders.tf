// Regional folder should only reference WAN core network
// No need to reference other regional folders (removes circular dependencies)

// Get WAN core network information
data "terraform_remote_state" "wan" {
  backend = "local"
  config = {
    path = "../wan/terraform.tfstate"
  }
}

// Get current AWS account info
data "aws_caller_identity" "current" {}

// Get current region
data "aws_region" "current" {}

// Optional: Get availability zones for current region
data "aws_availability_zones" "available" {
  state = "available"
}