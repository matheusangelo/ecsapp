data "network_state" "main" {

  backend = "local"

  config = {
    path = "../networks"
  }
}


resource "aws_ecs_cluster" "app" {
  name = "app-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode([{
    name  = "app-container"
    image = "${data.aws_ecr_repository.local_repo.repository_url}:latest"
  }])
}

resource "aws_ecs_service" "app" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.app.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets = [network_state.main.subnet_name]
    security_groups = [network_state.main.security_group_name]
  }
}