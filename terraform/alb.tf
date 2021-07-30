resource "aws_alb" "nodejs" {
  name               = "nodejs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.public.*.id

  enable_deletion_protection = false
}

resource "aws_alb_target_group" "nodejs" {
  name        = "nodejs-alb-tg"
  target_type = "ip"
  protocol    = "HTTP"
  port        = 3000

  vpc_id = aws_vpc.nodejs.id

  health_check {
    path                = "/health_check"
    port                = 3000
    healthy_threshold   = 6
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.nodejs.arn
  protocol          = "HTTP"
  port              = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.nodejs.arn
  }
}