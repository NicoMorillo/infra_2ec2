module "vpc" {
  source = "../module/vpc"

  environment = local.environment
  project     = local.project
  cidr_block  = local.cidr_block
  az_limit    = 2
}