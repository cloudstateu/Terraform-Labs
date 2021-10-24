locals {
  location = "westeurope"
  #TODO: moj prefix studenta
  studentPrefix = "tf-st60"
  tags = {
    "env"  = "dev"
    "task" = "zjazd3"
    #TODO: moj prefix studenta
    "user" = "tf-st60@chmfnd.onmicrosoft.com"
  }
}

#TODO: mifurm, generuje 3 literowy string by rozszerzyć nazwy swoich uslug
#TODO: dobre tylko na testy
resource "random_string" "mifurm-rand-prefix" {
  length  = 3
  special = false
}

#TODO: mifurm, ta grupa nie bedzie nam potrzebna
/*
resource "azurerm_resource_group" "main_rg" {
  name     = format("%s-%s", var.rg-name, local.studentPrefix)
  location = local.location
  tags     = local.tags
}*/

#TODO: mifurm, tutaj generuje pozostale grupy zasobow
#{PREFIX}-NETOPS-HUB dla sieci HUB
#{PREFIX}-NETOPS-DEV-SPOKE dla sieci SPOKE środowiska DEV
#{PREFIX}-NETOPS-PRD-SPOKE dla sieci SPOKE środowiska PRD
#{PREFIX}-NETOPS-DNS dla usług DNS
#{PREFIX}-VM-DEV dla maszyn środowiska DEV
resource "azurerm_resource_group" "netops-prd-hub" {
  name     = format("rg-%s-%s", local.studentPrefix, "netops-prd-hub")
  location = local.location
  tags     = local.tags
}

resource "azurerm_resource_group" "netops-dev-spoke" {
  name     = format("rg-%s-%s", local.studentPrefix, "netops-dev-spoke")
  location = local.location
  tags     = local.tags
}

resource "azurerm_resource_group" "netops-prd-spoke" {
  name     = format("rg-%s-%s", local.studentPrefix, "netops-prd-spoke")
  location = local.location
  tags     = local.tags
}

resource "azurerm_resource_group" "netops-prd-dns" {
  name     = format("rg-%s-%s", local.studentPrefix, "netops-prd-dns")
  location = local.location
  tags     = local.tags
}

resource "azurerm_resource_group" "vm-dev" {
  name     = format("rg-%s-%s", local.studentPrefix, "vm-dev")
  location = local.location
  tags     = local.tags
}

resource "azurerm_resource_group" "k8s-dev" {
  name     = format("rg-%s-%s", local.studentPrefix, "k8s-dev")
  location = local.location
  tags     = local.tags
}

resource "azurerm_resource_group" "kv-dev" {
  name     = format("rg-%s-%s", local.studentPrefix, "kv-dev")
  location = local.location
  tags     = local.tags
}

resource "azurerm_resource_group" "appservice-dev" {
  name     = format("rg-%s-%s", local.studentPrefix, "appservice-dev")
  location = local.location
  tags     = local.tags
}