
resource "azurerm_windows_virtual_machine" "win-build" {
  name                = "win-build"
  resource_group_name = azurerm_resource_group.rg-build-farm.name
  location            = azurerm_resource_group.rg-build-farm.location
  size                = "Standard_B2s"
  admin_username      = var.user
  admin_password      = var.secret
  network_interface_ids = [
    azurerm_network_interface.vnic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = "127"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter" #2022-datacenter-azure-edition
    version   = "latest"
  }
}