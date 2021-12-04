variable "clusterName" {
  default = "mifurmaro10"
}


resource "null_resource" "azure-cli" {
  
  provisioner "local-exec" {
    command = "./aro.sh"

    environment = {
       clustername = var.clusterName
       resource_group = "${var.clusterName}rg"
       location = "westeurope"
       vnetname = "${var.clusterName}-vnet"
       cluster_resource_group = "${var.clusterName}-cluster-rg"
       master_subnet_cidr = "10.0.0.0/23"
       worker_subnet_cidr = "10.0.2.0/23"
       vnet_cidr = "10.0.0.0/22"
    }
  }
}
