
resource_group_object_testrg = {
  name       = "test"
  location   = "westeurope"
  lock_level = ""
}

resource_group_tags_testrg = {
  app           = "App01"
  businessowner = "mifurm@cloudarchitects.pl"
  env           = "DEV"
  description   = "DevEnviroment"
}

resource_group_object_devrg = {
  name       = "devrg"
  location   = "westeurope"
  lock_level = ""
}

resource_group_tags_devrg = {
  app           = "dev01"
  businessowner = "mifurm@cloudarchitects.pl"
  env           = "DEV"
  description   = "DevEnviroment"
}