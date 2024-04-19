resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group_name_prefix}-RG"
  location = var.location
  tags     = var.tags
}