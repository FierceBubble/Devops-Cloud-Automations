resource "azurerm_network_security_group" "nsg" {
  name                = var.azure_nsg_name
  location            = var.rg_location
  resource_group_name = var.rg_name
}

resource "azurerm_network_security_rule" "node-health" {
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name

  name                       = "node-health"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "3389"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "k8s-allow-http" {
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name

  name                       = "k8s-allow-http"
  priority                   = 200
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "k8s-allow-https" {
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name

  name                       = "k8s-allow-https"
  priority                   = 300
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "443"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "ssh" {
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name

  name                       = "ssh"
  priority                   = 1000
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "k8s-allow-api-server" {
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name

  name                       = "k8s-allow-api-server"
  priority                   = 1001
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "6443"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "k8s-allow-kubectl-commands" {
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name

  name                       = "k8s-allow-kubectl-commands"
  priority                   = 1002
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "8080"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}

resource "azurerm_network_security_rule" "k8s-allow-kubelet-check" {
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name

  name                       = "k8s-allow-kubelet-check"
  priority                   = 1003
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "10248"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}
