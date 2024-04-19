resource "azurerm_log_analytics_workspace" "log_workspace" {
  name                = "${var.name_prefix}-log-workspace"
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  location            = var.location
  tags                = var.tags
}

resource "azurerm_recovery_services_vault" "recovery_vault" {
  name                = "${var.name_prefix}-recovery-vault"
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  soft_delete_enabled = true
  location            = var.location
  tags                = var.tags
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.name_prefix}storage"
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  location                 = var.location
  tags                     = var.tags
}