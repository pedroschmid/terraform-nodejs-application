resource "aws_security_group" "alb" {
  name        = "nodejs-alb-sg"
  description = "Allows inboud traffic through ALB"

  vpc_id = aws_vpc.nodejs.id

  ingress {
    description = "HTTP ingress"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "nodejs-alb-sg"
  }
}

resource "aws_security_group" "ecs" {
  name        = "nodejs-ecs-sg"
  description = "Allows inbound traffic from ALB to ECS"

  vpc_id = aws_vpc.nodejs.id

  ingress {
    description     = "ALB ingress"
    protocol        = "tcp"
    from_port       = 3000
    to_port         = 3000
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "nodejs-ecs-sg"
  }
}

resource "aws_security_group" "rds" {
  name        = "nodejs-rds-sg"
  description = "Allow inbound traffic from ECS to RDS"

  vpc_id = aws_vpc.nodejs.id

  ingress {
    description     = "ECS ingress"
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.ecs.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "nodejs-rds-sg"
  }
}