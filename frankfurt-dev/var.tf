// 1 var for vpc 

variable "gives_cidr_to_vpc" { // var_for_vpc can give anything 
  description = "CIDR block for the VPC"
  type        = string
  default     = "31.0.0.0/16"
}

// creating 6 subnets 3 public and 3 private

variable "gives_cidr_to_public_subnets" {
  description = "CIDR block for the public subnets"
  type        = list(string)
  default     = ["31.0.1.0/24", "31.0.2.0/24", "31.0.3.0/24"]
}

variable "gives_cidr_to_private_subnets" {
  description = "CIDR block for the private subnets"
  type        = list(string)
  default     = ["31.0.4.0/24", "31.0.5.0/24", "31.0.6.0/24"]
}

// crating 3 availability zones where both public and private subnets will be created in each zone .
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}