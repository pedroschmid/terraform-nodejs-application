resource "aws_alb" "nodejs" {
  name = "nodejs-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb.id]
  subnets = aws_subnet.public.*.id

  enable_deletion_protection = false
}