

module "alb" {
  source          = "./modules/lb"
  subnet_ids      = var.subnet_ids
  security_groups = [module.sg.sg_id,module.sg-product.sg_id,module.sg-user.sg_id]
}


