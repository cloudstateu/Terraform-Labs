variable "vm_object" {

    description = <<EOF
Obiekt definiujacy subnet
rg_name:                                Nazwa Resource Group
vnet_name:                              Nazwa Virtual Network
subnet_name:                            Nazwa subnetu

EOF

    type                                       = object({
        vm_name                                = string
        computer_name                          = string
        rg_name                                = string
        vnet_name                              = string
        vnet_rg_name                           = string
        subnet_name                            = string
        nic_enable_accelerated_networking      = bool
        static_private_ip                      = string
        os_type                                = string
        vm_size                                = string
        license_type                           = string
        offer                                  = string
        publisher                              = string
        sku                                    = string
        version                                = string
        admin_username                         = string
        admin_password                         = string
        caching                                = string
        storage_account_type                   = string
        disk_size                              = number
        
    })  
}
