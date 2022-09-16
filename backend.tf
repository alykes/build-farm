terraform {
  backend "azurerm" {
    resource_group_name  = "rg.tfstate"
    storage_account_name = "saangotfstate"
    container_name       = "buildfarm-tfstate"
    key                  = "buildfarm.terraform.tfstate"
  }
}