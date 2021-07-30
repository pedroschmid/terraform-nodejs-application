resource "aws_ecs_cluster" "nodejs" {
  name = "nodejs-cluster"
}

resource "aws_ecs_task_definition" "nodejs" {
  family                   = "nodejs"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  task_role_arn = aws_iam_role.ecs_host_role.arn
  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  
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