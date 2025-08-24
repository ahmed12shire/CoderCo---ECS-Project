module "ec2" {
    depends_on = [module.vpc]
    source     = "./modules/compute"
    subnet_id  = module.vpc.public_subnet_ids 
    vpc_security_group_ids = [module.vpc.public_sg_id]
}

module "vpc" {
    source = "./modules/network"
}