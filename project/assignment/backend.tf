terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten01569982RG"
    storage_account_name = "tfstaten01569982sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}