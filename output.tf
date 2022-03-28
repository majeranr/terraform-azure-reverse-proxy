output "rp_public_ip_address" {
  value = module.vms.public_ip_address
}

output "nat_gw_public_ip_address" {
  value = module.vnet.nat_gw_ip_address
}

output "tls_private_key" {
  value     = module.vms.tls_private_key
  sensitive = true
}

