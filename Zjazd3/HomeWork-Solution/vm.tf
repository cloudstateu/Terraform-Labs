resource "azurerm_availability_set" "avset-wfe-dev-01" {
  name                         = "avset-wfe-dev-01"
  location                     = azurerm_resource_group.vm-dev.location
  resource_group_name          = azurerm_resource_group.vm-dev.name
  platform_update_domain_count = 5
  platform_fault_domain_count  = 3
}

resource "azurerm_public_ip" "VM-WFE01-DEV-PIP" {
  name                    = "VM-WFE01-DEV-PIP"
  location                = azurerm_resource_group.vm-dev.location
  resource_group_name     = azurerm_resource_group.vm-dev.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}

resource "azurerm_network_interface" "VM-WFE01-DEV-NIC01" {
  name                = "VM-WFE01-DEV-NIC01"
  location            = azurerm_resource_group.vm-dev.location
  resource_group_name = azurerm_resource_group.vm-dev.name

  ip_configuration {
    name                          = "VM-WFE01-DEV-NIC01-CONFIG"
    subnet_id                     = azurerm_subnet.vnet-spoke-prd-private-vm-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.VM-WFE01-DEV-PIP.id
  }
}

resource "azurerm_network_interface" "VM-WFE01-DEV-NIC02" {
  name                = "VM-WFE01-DEV-NIC02"
  location            = azurerm_resource_group.vm-dev.location
  resource_group_name = azurerm_resource_group.vm-dev.name

  ip_configuration {
    name                          = "VM-WFE01-DEV-NIC02-CONFIG"
    subnet_id                     = azurerm_subnet.vnet-spoke-prd-private-vm-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "VM-WFE01-DEV" {
  name                = "VM-WFE01-DEV"
  computer_name       = "VM-WFE01-DEV"
  location            = azurerm_resource_group.vm-dev.location
  resource_group_name = azurerm_resource_group.vm-dev.name
  size                = "Standard_B2s"

  availability_set_id = azurerm_availability_set.avset-wfe-dev-01.id

  disable_password_authentication = false
  admin_username                  = "mifurm"
  admin_password                  = "pobierzSobieHasloZKeyVault123!@#123!@#"

  network_interface_ids = [
    azurerm_network_interface.VM-WFE01-DEV-NIC01.id,
    azurerm_network_interface.VM-WFE01-DEV-NIC02.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    name                 = "VM-WFE01-DEV-OS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_managed_disk" "VM-WFE01-DEV-DATA-DISK" {

  name                 = "VM-WFE01-DEV-DATA-DISK"
  location             = azurerm_resource_group.vm-dev.location
  resource_group_name  = azurerm_resource_group.vm-dev.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  #sprawdz inne opcje niz Empty dla Create
  disk_size_gb = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "VM-WFE01-DEV-DATA-DISK-ATTACHMENT" {
  managed_disk_id    = azurerm_managed_disk.VM-WFE01-DEV-DATA-DISK.id
  virtual_machine_id = azurerm_linux_virtual_machine.VM-WFE01-DEV.id
  lun                = "10"
  caching            = "ReadWrite"
}