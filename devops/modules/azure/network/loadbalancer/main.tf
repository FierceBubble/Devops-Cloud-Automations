resource "azurerm_public_ip" "loadbalancer-public_ip" {
  name                = "loadbalancer-public_ip"
  resource_group_name = var.rg_name
  location            = var.rg_location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "lb" {
  name                = var.azure_lb_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  sku_tier            = "Regional"

  frontend_ip_configuration {
    name                 = var.azure_lb_ipconfig_name
    public_ip_address_id = azurerm_public_ip.loadbalancer-public_ip.id
    # subnet_id            = var.azure_subnet_id
    # private_ip_address   = "10.230.0.1"
  }
}

resource "azurerm_lb_backend_address_pool" "nodes" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "azure-nodes"
}

# resource "azurerm_lb_backend_address_pool_address" "nodes" {
#   name                    = "lb-nodes"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.nodes.id
#   virtual_network_id      = var.vnet_id
#   ip_address              = azurerm_public_ip.loadbalancer-public_ip.ip_address
#   #   backend_address_ip_configuration_id = azurerm_lb.lb.frontend_ip_configuration[0].id
# }

resource "azurerm_lb_rule" "http" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "LB-HTTP"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.azure_lb_ipconfig_name
}

resource "azurerm_lb_rule" "https" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "LB-HTTPS"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = var.azure_lb_ipconfig_name
}

resource "azurerm_lb_probe" "http" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "http-running-probe"
  port            = 80
}

resource "azurerm_lb_probe" "https" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "https-running-probe"
  port            = 443
}
