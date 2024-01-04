variable environment {
  type        = string
  default     = "dev"
  description = "env app"
}

variable availability_zones {
  type    = list(string)
  default = ["us-east-1a"]
  description = "az"
}


variable public_subnets_cidr {
  type    = list(string)
  default = ["172.20.0.0/16"]
  description = "public_subnets_cidr"
}
