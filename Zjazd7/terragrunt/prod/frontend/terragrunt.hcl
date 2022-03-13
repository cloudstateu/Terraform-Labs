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
  app_subscription_id = local.common.locals.frontend_subscription_id
  app_name            = "terragruntosrmfrontend"
  docker_image        = "osrm/osrm-frontend:latest"
  app_settings        = {
    OSRM_BACKEND = "https://terragruntosrmbackend.azurewebsites.net"
    WEBSITE_PORT = "9966"
  }
  resource_tags = {
    Owner = "Frontend Team"
  }
}
