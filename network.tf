resource "azurerm_virtual_network" "vnet" {
  name                = "vnet.rg-buildfarm"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-build-farm.location
  resource_group_name = azurerm_resource_group.rg-build-farm.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet00"
  resource_group_name  = azurerm_resource_group.rg-build-farm.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "public-ip" {
  name                = "win-build-public-ip"
  resource_group_name = azurerm_resource_group.rg-build-farm.name
  location            = azurerm_resource_group.rg-build-farm.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "vnic" {
  name                = "vnic"
  location            = azurerm_resource_group.rg-build-farm.location
  resource_group_name = azurerm_resource_group.rg-build-farm.name

  ip_configuration {
    name                          = "win-build-ip"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-ip.id
  }
}