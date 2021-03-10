######
# ELB
######
module "elb" {
  source = "./modules/elb"

  create_elb = true

  name        = var.name

  subnets         = ["subnet-024d03616522c6a61", "subnet-07cb41e7b435c8d73"]
  security_groups = ["sg-0d25b39d9e7c06452"]
  internal        = var.internal

  cross_zone_load_balancing   = true
  idle_timeout                = 60
  connection_draining         = false
  connection_draining_timeout = 300

  listener = [
    {
      instance_port     = "8200"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    }
  ]

  health_check = {
    target              = "HTTP:8200/v1/sys/health"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

}

#################
# ELB attachment
#################
module "elb_attachment" {
  source = "./modules/elb_attachment"

  create_attachment = true

  number_of_instances = 1

  elb       = module.elb.this_elb_id
  instances = var.instances
}
