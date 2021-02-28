# EC2 AMI images
data "aws_ssm_parameter" "amz2-ami-primary" {
  provider = aws.primary
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# EC2 Primary-VPC Instance creation

# Instances in Primary-VPC public az-a
resource "aws_instance" "web-server-paz-a" {
  provider                    = aws.primary
  count                       = var.primary-web.count
  ami                         = data.aws_ssm_parameter.amz2-ami-primary.value
  instance_type               = var.primary-web.instance-type
  key_name                    = "udacity"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.primary-web-tier.id]
  subnet_id                   = aws_subnet.primary-subnet-01.id
  tags = merge(
    var.udc_default_tags,
    {
      Name = join("-", ["Udacity t2 - web-server", count.index + 1, "a"])
      Tier = "Web"
    }
  )
  root_block_device {
    volume_type = var.primary-web.storage-type
    volume_size = var.primary-web.storage-size
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "rds_main"
  provider   = aws.primary
  subnet_ids = [aws_subnet.primary-subnet-01.id, aws_subnet.primary-subnet-02.id]

  tags =  var.udc_default_tags
}


