resource "aws_db_subnet_group" "nodejs" {
  name       = "nodejs-rds-subnet-group"
  subnet_ids = aws_subnet.private.*.id
}

resource "aws_db_instance" "nodejs" {
  identifier = "nodejs-rds"

  engine              = "mysql"
  engine_version      = "5.7"
  instance_class      = "db.t2.micro"
  allocated_storage   = 10
  skip_final_snapshot = true

  name     = var.RDS_NAME
  username = var.RDS_USERNAME
  password = var.RDS_PASSWORD

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.nodejs.name
  multi_az               = false
  publicly_accessible    = false
}