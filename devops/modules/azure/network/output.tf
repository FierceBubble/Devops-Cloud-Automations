output "nic_id" {
  value = azurerm_network_interface.nic.id
}

output "worker-nic-ids" {
  value = azurerm_network_interface.worker_nic[*].id
}

output "worker-private-ip" {
  value = azurerm_network_interface.worker_nic[*].private_ip_address
}

output "azure_lb_public_ip" {
  value = module.loadbalancer.azure_lb_public_ip
}
