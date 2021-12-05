resource "azurerm_public_ip" "VM-WFE01-DEV-PIP" {
  name                    = "VM-WFE01-DEV-PIP"
  location                = azurerm_resource_group.homework-rg.location
  resource_group_name     = azurerm_resource_group.homework-rg.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}

resource "azurerm_network_interface" "VM-WFE01-DEV-NIC" {
  name                = "VM-WFE01-DEV-NIC"
  location            = azurerm_resource_group.homework-rg.location
  resource_group_name = azurerm_resource_group.homework-rg.name

  ip_configuration {
    name                          = "VM-WFE01-DEV-NIC-CONFIG"
    subnet_id                     = azurerm_subnet.vnet-hub-private-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.VM-WFE01-DEV-PIP.id
  }
}

resource "azurerm_linux_virtual_machine" "VM-WFE01-DEV" {
  name                = "VM-WFE01-DEV"
  computer_name       = "VM-WFE01-DEV"
  location            = azurerm_resource_group.homework-rg.location
  resource_group_name = azurerm_resource_group.homework-rg.name
  size                = "Standard_B2s"

  disable_password_authentication = false
  admin_username                  = "mifurm"
  admin_password                  = "pobierzSobieHasloZKeyVault123!@#"

  network_interface_ids = [
    azurerm_network_interface.VM-WFE01-DEV-NIC.id,
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
  location             = azurerm_resource_group.homework-rg.location
  resource_group_name  = azurerm_resource_group.homework-rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  #sprawdz inne opcje niz Empty dla Create
  disk_size_gb = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  managed_disk_id    = azurerm_managed_disk.VM-WFE01-DEV-DATA-DISK.id
  virtual_machine_id = azurerm_linux_virtual_machine.VM-WFE01-DEV.id
  lun                = "10"
  caching            = "ReadWrite"
}


data "azurerm_monitor_diagnostic_categories" "azurerm_monitor_diagnostic_setting_vm" {
  resource_id = azurerm_linux_virtual_machine.VM-WFE01-DEV.id
}

output "azurerm_monitor_diagnostic_setting_vm_logs" {
  value = data.azurerm_monitor_diagnostic_categories.azurerm_monitor_diagnostic_setting_vm.logs
}

output "azurerm_monitor_diagnostic_setting_vm_metrics" {
  value = data.azurerm_monitor_diagnostic_categories.azurerm_monitor_diagnostic_setting_vm.metrics
}


resource "azurerm_monitor_diagnostic_setting" "VM-WFE01-DEV-monitoring" {

  name               = "diagnostics-${azurerm_linux_virtual_machine.VM-WFE01-DEV.name}"
  target_resource_id = azurerm_linux_virtual_machine.VM-WFE01-DEV.id

  log_analytics_workspace_id = azurerm_log_analytics_workspace.dev-monitor-loganal01.id

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
    }
  }
}

resource "azurerm_virtual_machine_extension" "mmaagent" {
  name                       = "mmaagent"
  virtual_machine_id         = azurerm_linux_virtual_machine.VM-WFE01-DEV.id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.13"
  auto_upgrade_minor_version = "true"
  settings                   = <<SETTINGS
    {
      "workspaceId": "${azurerm_log_analytics_workspace.dev-monitor-loganal01.workspace_id}"
    }
SETTINGS
  protected_settings         = <<PROTECTED_SETTINGS
   {
      "workspaceKey": "${azurerm_log_analytics_workspace.dev-monitor-loganal01.primary_shared_key}"
   }
PROTECTED_SETTINGS
}