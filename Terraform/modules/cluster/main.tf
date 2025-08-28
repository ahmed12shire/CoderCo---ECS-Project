resource "aws_ecs_cluster" "cluster" {
  name = "${var.project_name}-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                   = var.project_name
  network_mode             = "bridge"  # Use EC2 instances
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([{
    name      = "ecs-container"
    image     = "${aws_ecr_repository.app.repository_url}:${var.image_tag}"
    essential = true
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
      protocol      = "tcp"
    }]
  }])

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-task"
  })
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 2
  launch_type     = "EC2"  # Running on EC2 instances
  network_configuration {
    subnets          = module.vpc.public_subnet_ids
    security_groups = [aws_security_group.public_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app_target_group.arn
    container_name   = "ecs-container"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.http]
}
