output "rg_name_output" {
  value = module.rgroup.rg_output.name
}
output "vnet_name_output" {
  value = module.network.vnet_output.name
}
output "vnet_address_space_output" {
  value = module.network.vnet_output.address_space
}
output "subnet_name_output" {
  value = module.network.subnet_output.name
}
output "subnet_address_space_output" {
  value = module.network.subnet_output.address_prefixes
}
output "nsg_name_output" {
  value = module.network.nsg_output.name
}
output "avs_linux_name_output" {
  value = module.vmlinux.avs_linux_output.name
}
output "vm_linux_hostnames_output" {
  value = module.vmlinux.vm_linux_hostname_output
}
output "vm_linux_fqdns_output" {
  value = module.vmlinux.vm_linux_fqdn_output
}
output "vm_linux_private_ips_output" {
  value = module.vmlinux.vm_linux_private_ip_output
}
output "vm_linux_public_ips_output" {
  value = module.vmlinux.vm_linux_public_ip_output
}
output "lb_name_output" {
  value = module.loadbalancer.lb_output.name
}
output "lb_fqdn_output" {
  value = module.loadbalancer.lbfqdn_output
}