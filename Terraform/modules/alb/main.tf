resource "aws_lb" "app_lb" {
  name               = "${var.project_name}-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids 
  subnets            = var.public_subnet_ids
  enable_deletion_protection = false

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-app-lb"
  })
}

resource "aws_lb_target_group" "app_target_group" {
  name     = "${var.project_name}-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-app-tg"
  })
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      status_code = 200
      message_body = "OK"
      content_type = "text/plain"
    }
  }
}

