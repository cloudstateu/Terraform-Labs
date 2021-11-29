data "azurerm_resource_group" "ab_rg_vm" {
    name        = var.vm_object.rg_name
}

data "azurerm_subnet" "ab_vm_subnet" {
    name                 = var.vm_object.subnet_name
    virtual_network_name = var.vm_object.vnet_name
    resource_group_name  = var.vm_object.vnet_rg_name
}

resource "azurerm_network_interface" "ab_vm_nic" {

    name                    = "${var.vm_object.vm_name}-nic"
    location                = data.azurerm_resource_group.ab_rg_vm.location
    resource_group_name     = data.azurerm_resource_group.ab_rg_vm.name

    enable_accelerated_networking = var.vm_object.nic_enable_accelerated_networking

    ip_configuration {
        name                          = "${var.vm_object.vm_name}-ip_config"
        subnet_id                     = data.azurerm_subnet.ab_vm_subnet.id
        private_ip_address_allocation = var.vm_object.static_private_ip == null ? "Dynamic" : "Static"
        private_ip_address            = var.vm_object.static_private_ip
    }

    lifecycle {
        ignore_changes = [
            tags
        ]
    }
}

resource "azurerm_linux_virtual_machine" "ab_vm" {

    name                  = var.vm_object.vm_name
    location              = data.azurerm_resource_group.ab_rg_vm.location
    resource_group_name   = data.azurerm_resource_group.ab_rg_vm.name
    network_interface_ids = [
        azurerm_network_interface.ab_vm_nic.id
    ]
    size                  = var.vm_object.vm_size
    
    source_image_reference {
        offer     = var.vm_object.offer
        publisher = var.vm_object.publisher
        sku       = var.vm_object.sku
        version   = var.vm_object.version
    }
   
    os_disk {
        name                 = "${var.vm_object.vm_name}-osdisk-01"
        caching              = var.vm_object.caching
        storage_account_type = var.vm_object.storage_account_type
        disk_size_gb         = var.vm_object.disk_size
    }

    computer_name       = var.vm_object.computer_name
    
    provision_vm_agent              = true
    disable_password_authentication = true

    admin_username                  = var.vm_object.admin_username

    admin_ssh_key {
        username   = var.vm_object.admin_username
        public_key = file("${var.vm_object.ssh_pub_key}")
    }

    lifecycle {
        ignore_changes = [
            tags
        ]
    }    
}