resource "azurerm_network_security_group" "rdp-wfh" {
  name                = "nsg-rg.buildfarm"
  location            = azurerm_resource_group.rg-build-farm.location
  resource_group_name = azurerm_resource_group.rg-build-farm.name

  security_rule {
    name                       = "rdp-wfh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "${data.external.wfh_public_ip.result.ip}/32"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "build-farm"
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.vnic.id
  network_security_group_id = azurerm_network_security_group.rdp-wfh.id
}