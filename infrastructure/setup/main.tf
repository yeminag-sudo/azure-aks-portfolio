terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 1. Create a Resource Group for our Setup tools
resource "azurerm_resource_group" "setup" {
  name     = "rg-terraform-state"
  location = "eastus"
}

# 2. Create a Random String (because Storage Account names must be unique globally)
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# 3. Create the Storage Account (to hold the Terraform State)
resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.setup.name
  location                 = azurerm_resource_group.setup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# 4. Create the Container inside the Storage Account
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

# 5. Output the Storage Account Name (You will need this!)
output "storage_account_name" {
  value = azurerm_storage_account.tfstate.name
}