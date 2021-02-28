resource "aws_security_group" "primary-web-tier" {
  provider    = aws.primary
  name        = "primary-web-tier-sg"
  description = "Web Tier SG"
  vpc_id      = aws_vpc.primary-vpc.id

  ingress {
    description = "SSH"
    from_port   = var.ssh-traffic-port
    to_port     = var.ssh-traffic-port
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.primary-vpc.cidr_block, "0.0.0.0/0"] #SSH from anywhere not secure. However rsa private key needed.
    
  }

  ingress {
    description = "rds"
    from_port   = var.database-traffic-port
    to_port     = var.database-traffic-port
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.primary-vpc.cidr_block, "0.0.0.0/0"] #SSH from anywhere not secure. However rsa private key needed.
    
  }


  ingress {
    description = "HTTP Traffc"
    from_port   = var.http-traffic-port
    to_port     = var.http-traffic-port
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.primary-vpc.cidr_block, "0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.udc_default_tags,
    {
      Name = "primary-web-tier-sg"
    }
  )
}



# Primary Subnet Public 1
resource "aws_subnet" "primary-subnet-01" {
  provider                = aws.primary
  vpc_id                  = aws_vpc.primary-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.primary.public-subnet-01
  map_public_ip_on_launch = true
  tags = merge(
    var.udc_default_tags,
    {
      Name = "Primary Public Subnet 01"
    }
  )
}

# Primary Subnet Public 1
resource "aws_subnet" "primary-subnet-02" {
  provider                = aws.primary
  vpc_id                  = aws_vpc.primary-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.primary.public-subnet-02
  map_public_ip_on_launch = true
  tags = merge(
    var.udc_default_tags,
    {
      Name = "Primary Public Subnet 02"
    }
  )
}
