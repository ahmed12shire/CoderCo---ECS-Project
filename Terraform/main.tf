module "vpc" {
    source = "./modules/network"
}


module "ec2" {
    depends_on = [module.vpc]
    source     = "./modules/compute"
    subnet_id  = module.vpc.public_subnet_ids 
    vpc_security_group_ids = [module.vpc.public_sg_id]
}

module "ecs_cluster" {
  source = "./modules/compute"
  cluster_name = var.project_name
}

module "ecr" {
  source = "./modules/ecr"
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