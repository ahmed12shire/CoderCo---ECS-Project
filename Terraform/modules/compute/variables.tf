variable "instance_type" {
    type = string 
    default = "t3.micro"
    
}

variable "tags" {
  description = "Common tags for resources"
  type        = map(string)
  default = {
    Project = "ecsproject"
    Owner   = "devOps-Team"
    Env     = "dev"
  }
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = "ecsproject-instance"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}

variable "subnet_id" {
  description = "Subnet ID for the EC2"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to attach to EC2 instances"
  type        = list(string)
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "ecr_repository" {
  description = "ECR repository name"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
}

variable "ecs_instance_role_name" {
  description = "The name of the IAM role to associate with the EC2 instance"
  type        = string
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}
locals {
    instance_ami = data.aws_ami.ubuntu.id
}

