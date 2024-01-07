resource "aws_vpc" "vpc" {
  enable_dns_hostnames = true
  enable_dns_support   = true
  cidr_block = "0.0.0.0/16"

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = "${var.environment}"
  }
}