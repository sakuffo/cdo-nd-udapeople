resource "aws_db_instance" "default" {
  provider = aws.primary
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "12.5"
  instance_class       = "db.t2.micro"
  name                 = "udacitycdo"
  username             = "udacitycdo"
  password             = "udacitycdo"
  port                 = 5432
  identifier           = "udacitycdo"
  publicly_accessible  = true
  skip_final_snapshot  = true
  tags =  var.udc_default_tags
}