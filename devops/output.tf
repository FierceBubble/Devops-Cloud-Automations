output "LoadBalancer-public_ip" {
  value = module.network.azure_lb_public_ip
}

output "MasterNode-public_ip" {
  value = azurerm_linux_virtual_machine.master.public_ip_address
}

output "MasterNode-private_ip" {
  value = azurerm_linux_virtual_machine.master.private_ip_address
}

output "WorkerNode-private-ips" {
  value = module.network.worker-private-ip
}
