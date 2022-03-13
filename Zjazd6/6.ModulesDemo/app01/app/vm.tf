module "vm01" {
    source = "../../MODULES/virtual-machine-linux"

    vm_object = {
        vm_name                                = "vm01"
        computer_name                          = "vm01"
        rg_name                                = data.azurerm_resource_group.module01-rg.name
        vnet_name                              = data.azurerm_virtual_network.vnet-dev-01.name
        vnet_rg_name                           = data.azurerm_resource_group.module01-rg.name
        subnet_name                            = data.azurerm_subnet.subnet-01.name
        nic_enable_accelerated_networking      = false
        static_private_ip                      = "10.0.0.4"
        os_type                                = "Linux"
        vm_size                                = "Standard_DS1_v2"
        offer                                  = "UbuntuServer"
        publisher                              = "Canonical"
        sku                                    = "18.04-LTS"
        version                                = "latest"
        admin_username                         = "mifurm"
        ssh_pub_key                            = file("id_rsa.pub")
        caching                                = "ReadWrite"
        storage_account_type                   = "Standard_LRS"
        disk_size                              = "32"
    }

}