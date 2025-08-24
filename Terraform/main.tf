module "ec2" {
    depends_on = [module.vpc]
    source     = ".\modules\compute"
    subnet_id  = module.vpc.public_subnet_ids 
}

module "vpc" {
    source = ".\modules\network"
}