resource "azurerm_container_registry" "acr" {
  name                = "acr${var.environment}${random_string.suffix.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true # Easy access for demo purposes
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}