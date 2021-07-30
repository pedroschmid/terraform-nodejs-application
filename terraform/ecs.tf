resource "aws_ecs_cluster" "nodejs" {
  name = "nodejs-cluster"
}

resource "aws_ecs_task_definition" "nodejs" {
  family                   = "nodejs"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  task_role_arn            = aws_iam_role.ecs_host_role.arn
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "nodejs-container"
      image     = aws_ecr_repository.nodejs.repository_url
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ],
      "environment" = [
        {
          "name"  = "PORT",
          "value" = "3000"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "nodejs" {
  name            = "nodejs-ecs-service"
  cluster         = aws_ecs_cluster.nodejs.id
  task_definition = aws_ecs_task_definition.nodejs.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  depends_on = [
    aws_iam_role_policy.ecs_execution_role_policy
  ]

  load_balancer {
    container_name   = "nodejs-container"
    container_port   = 3000
    target_group_arn = aws_alb_target_group.nodejs.arn
  }

  network_configuration {
    subnets          = aws_subnet.private.*.id
    security_groups  = [aws_security_group.alb.id, aws_security_group.ecs.id]
    assign_public_ip = false
  }

}