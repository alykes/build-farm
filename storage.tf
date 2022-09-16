resource "azurerm_resource_group" "rg-build-farm" {
  name     = "rg.buildfarm"
  location = "Australia East"
}

resource "azurerm_storage_account" "sa-build-farm" {
  name                            = "sabuildfarm"
  resource_group_name             = azurerm_resource_group.rg-build-farm.name
  location                        = azurerm_resource_group.rg-build-farm.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "buildfarm"
  storage_account_name  = azurerm_storage_account.sa-build-farm.name
  container_access_type = "private"
}