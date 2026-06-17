# ECS Cluster
resource "aws_ecs_cluster" "ecosmart_cluster" {
  name = "ecosmart-production-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "ecosmart-production-cluster"
  }
}

# ECS Task Definition
resource "aws_ecs_task_definition" "ecosmart_task" {
  family                   = "ecosmart-production"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name  = "ecosmart-production"
    image = "${aws_ecr_repository.ecosmart_repo.repository_url}:latest"
    portMappings = [{
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    }]
    essential = true
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = "/ecs/ecosmart-production"
        "awslogs-region"        = "us-east-1"
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "ecosmart_logs" {
  name              = "/ecs/ecosmart-production"
  retention_in_days = 7
}

# ECS Service
resource "aws_ecs_service" "ecosmart_service" {
  name            = "ecosmart-production-service"
  cluster         = aws_ecs_cluster.ecosmart_cluster.id
  task_definition = aws_ecs_task_definition.ecosmart_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecosmart_tg.arn
    container_name   = "ecosmart-production"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.ecosmart_listener]
}
