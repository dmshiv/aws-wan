// 1 var for vpc 

variable "gives_cidr_to_vpc" { // var_for_vpc can give anything 
  description = "CIDR block for the VPC"
  type        = string
  default     = "51.0.0.0/16"
}

// 2 var for public subnets
variable "gives_cidr_to_public_subnets" {
  description = "CIDR block for the public subnets"
  type        = list(string)
  default     = ["51.0.1.0/24", "51.0.2.0/24", "51.0.3.0/24"]
}

// 3 var for private subnets
variable "gives_cidr_to_private_subnets" {
  description = "CIDR block for the private subnets"
  type        = list(string)
  default     = ["51.0.4.0/24", "51.0.5.0/24", "51.0.6.0/24"]
}

// 4 var for availability zones
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"] # Virginia region AZs
}

