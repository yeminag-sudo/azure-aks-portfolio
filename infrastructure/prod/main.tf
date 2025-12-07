# 1. Create the Resource Group for Prod
resource "azurerm_resource_group" "main" {
  name     = "rg-aks-prod"
  location = "eastus"
}

# 2. Call the Networking Module
module "networking" {
  source              = "../modules/networking"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment         = "prod"
}

# 3. Call the AKS Module
module "aks" {
  source              = "../modules/aks"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment         = "prod"
  
  # This is the MAGIC connection: 
  # We pass the ID of the subnet created in the networking module
  vnet_subnet_id      = module.networking.aks_subnet_id
}

# 4. Call the ACR Module
module "acr" {
  source              = "../modules/acr"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  environment         = "prod"
}

# 5. Output the critical info (so you can see it)
output "acr_login_server" {
  value = module.acr.acr_login_server
}

output "acr_password" {
  value     = module.acr.acr_admin_password
  sensitive = true
}
