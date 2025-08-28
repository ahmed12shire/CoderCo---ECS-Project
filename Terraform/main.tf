module "vpc" {
    source = "./modules/network"
}


module "ec2" {
    depends_on = [module.vpc]
    source     = "./modules/compute"
    subnet_id  = module.vpc.public_subnet_ids 
    vpc_security_group_ids = [module.vpc.public_sg_id]
    aws_account_id         = var.aws_account_id
    aws_region             = var.aws_region
    ecr_repository         = module.ecr.ecr_repository_url   
    image_tag              = var.image_tag
}

module "ecs_cluster" {
  source = "./modules/cluster"
  cluster_name = var.project_name
}

module "ecr" {
  source = "./modules/ecr"
  project_name    = var.project_name
  repository_name = var.repository_name
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "route53" {
  source = "./modules/route53"
  domain_name = var.domain_name
  alb_dns_name = module.alb.alb_dns_name
}