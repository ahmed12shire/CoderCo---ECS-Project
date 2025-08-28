variable "project_name" {
  default = "ecs-project"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "domain_name" {
  description = "Domain name registered with Route 53 (e.g., example.com)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}

variable "subnet_id" {
  description = "Subnet ID for EC2 instances"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "VPC security group IDs for EC2 instances"
  type        = list(string)
}

variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "aws_account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "image_tag" {
  type        = string
  description = "Docker image tag"
}
