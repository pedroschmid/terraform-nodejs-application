resource "aws_iam_role" "ecs_host_role" {
  name               = "EcsHostRole"
  assume_role_policy = file("policies/ecs/ecs-role.json")
}

resource "aws_iam_role_policy" "ecs_instance_role_policy" {
  name   = "EcsInstanceRolePolicy"
  policy = file("policies/ecs/ecs-instance-role-policy.json")
  role   = aws_iam_role.ecs_host_role.id
}

resource "aws_iam_role" "ecs_service_role" {
  name               = "EcsService-Role"
  assume_role_policy = file("policies/ecs/ecs-role.json")
}

resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name   = "EcsServiceRolePolicy"
  policy = file("policies/ecs/ecs-service-role-policy.json")
  role   = aws_iam_role.ecs_service_role.id
}

resource "aws_iam_instance_profile" "ecs" {
  name = "EcsInstanceProfile"
  path = "/"
  role = aws_iam_role.ecs_host_role.name
}

resource "aws_iam_role" "ecs_execution_role" {
  name               = "EcsTaskExecutionRole"
  assume_role_policy = file("policies/ecs/ecs-task-execution-role.json")
}

resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  name   = "EcsExecutionRolePolicy"
  policy = file("policies/ecs/ecs-execution-role-policy.json")
  role   = aws_iam_role.ecs_execution_role.id
}