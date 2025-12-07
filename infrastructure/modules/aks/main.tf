# infrastructure/modules/aks/main.tf

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.environment}-aks-cluster"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.environment}-aks"

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_D2s_v3" # Cheap but good enough for demo
    vnet_subnet_id = var.vnet_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure" # The "Pro" setting (CNI)
    network_policy = "azure"
    service_cidr   = "10.100.0.0/16" # Internal K8s service IPs
    dns_service_ip = "10.100.0.10"
  }

  tags = {
    Environment = var.environment
  }
}