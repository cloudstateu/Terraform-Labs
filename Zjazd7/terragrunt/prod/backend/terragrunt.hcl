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
  app_subscription_id = local.common.locals.backend_subscription_id
  app_name            = "terragruntosrmbackend"
  docker_image        = "dawidholka/osrm-pomorskie:1.0"
  app_settings        = {
    WEBSITE_PORT = "5000"
  }
  resource_tags = {
    Owner = "Backend Team"
  }
}
