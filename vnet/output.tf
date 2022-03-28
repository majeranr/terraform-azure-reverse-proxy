output "rp_ani_id" {
  value = azurerm_network_interface.rp_ani.id
}

output "web01_ani_id" {
  value = azurerm_network_interface.web_vm_01_ani.id
}

output "web02_ani_id" {
  value = azurerm_network_interface.web_vm_02_ani.id
}

output "nat_gw_ip_address" {
  value = azurerm_public_ip.nat_ip.ip_address
}
