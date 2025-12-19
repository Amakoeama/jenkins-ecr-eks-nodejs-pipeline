
#--- Data Sources ---

# --- Amazon Linux 2 AMI ---

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# --- Default VPC ---

data "aws_vpc" "default" {
  default = true
}

# --- Default public subnet ---

data "aws_subnet" "default" {
  default_for_az    = true
  availability_zone = "us-east-1a"
  vpc_id            = data.aws_vpc.default.id
}

