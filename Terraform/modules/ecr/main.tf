resource "aws_ecr_repository" "ecs_repo" {
  name         = var.repository_name
  force_delete = true

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-repo"
  })
}

