include "root" {
  path = find_in_parent_folders()
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

terraform {
  source = "${get_terragrunt_dir()}/../../terraform/app"
}

inputs = {
  location            = local.common.locals.location
  app_subscription_id = local.common.locals.demo_subscription_id
  app_name            = "terragrunttest1"
  docker_image        = "dawidholka/laravel-octane-roadrunner:1.0.0"
  app_settings        = {
    APP_KEY = "base64:uynE8re8ybt2wabaBjqMwQvLczKlDSQJHCepqxmGffE="
  }
  resource_tags = {
    Owner = "Dawid"
  }
}
