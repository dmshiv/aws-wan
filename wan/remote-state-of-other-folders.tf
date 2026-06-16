// WAN folder should not reference remote states since it's deployed first
// The regional folders will reference the WAN state, not the other way around

// Get current AWS account info
data "aws_caller_identity" "current" {}

// Get current region
data "aws_region" "current" {}

// Optional: Get availability zones for current region
data "aws_availability_zones" "available" {
  state = "available"
}