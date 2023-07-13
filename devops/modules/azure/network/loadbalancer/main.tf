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
  }
}

resource "azurerm_lb_backend_address_pool" "nodes" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "azure-nodes"
}

resource "azurerm_lb_rule" "http" {
  loadbalancer_id         = azurerm_lb.lb.id
  name                    = "LB-HTTP"
  protocol                = "Tcp"
  frontend_port           = 80
  backend_port            = 80
  disable_outbound_snat   = true
  probe_id                = azurerm_lb_probe.http.id
  idle_timeout_in_minutes = 4

  frontend_ip_configuration_name = var.azure_lb_ipconfig_name
}

resource "azurerm_lb_rule" "https" {
  loadbalancer_id         = azurerm_lb.lb.id
  name                    = "LB-HTTPS"
  protocol                = "Tcp"
  frontend_port           = 443
  backend_port            = 443
  disable_outbound_snat   = true
  probe_id                = azurerm_lb_probe.https.id
  idle_timeout_in_minutes = 4

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

resource "azurerm_lb_nat_rule" "ssh" {
  resource_group_name     = var.rg_name
  loadbalancer_id         = azurerm_lb.lb.id
  name                    = "SSH"
  protocol                = "Tcp"
  frontend_port_start     = 220
  frontend_port_end       = 222
  backend_port            = 22
  idle_timeout_in_minutes = 4
  backend_address_pool_id = azurerm_lb_backend_address_pool.nodes.id

  enable_floating_ip             = false
  frontend_ip_configuration_name = var.azure_lb_ipconfig_name
}

resource "azurerm_lb_outbound_rule" "outbound" {
  name                    = "OutboundRule"
  loadbalancer_id         = azurerm_lb.lb.id
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.nodes.id

  frontend_ip_configuration {
    name = var.azure_lb_ipconfig_name
  }
}
