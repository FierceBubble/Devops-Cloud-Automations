output "backend_address_pool_id" {
  value = azurerm_lb_backend_address_pool.nodes.id
}

output "azure_lb_public_ip" {
  value = azurerm_public_ip.loadbalancer-public_ip.ip_address
}
