include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_terragrunt_dir()}/../../terraform/app_gw"
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

dependency "backend" {
  config_path = "${get_terragrunt_dir()}/../backend"
}

dependency "frontend" {
  config_path = "${get_terragrunt_dir()}/../frontend"
}

dependency "demo" {
  config_path = "${get_terragrunt_dir()}/../demo"
}

inputs = {
  location               = local.common.locals.location
  app_gw_subscription_id = local.common.locals.app_gw_subscription_id
  domain_name            = "azuretest.pl"
  apps                   = {
    backend = {
      name            = "backend"
      backend_address = dependency.backend.outputs.fqdn
      probe_path      = "/route/v1/driving/58,18;58,19"
    }
    frontend = {
      name            = "frontend"
      backend_address = dependency.frontend.outputs.fqdn
      probe_path      = "/"
    }
    demo = {
      name            = "demo"
      backend_address = dependency.demo.outputs.fqdn
      probe_path      = "/"
    }
  }
  resource_tags = {
    Owner = "Dawid"
  }
}

