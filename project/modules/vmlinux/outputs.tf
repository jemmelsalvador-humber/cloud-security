output "avs_linux_output" {
  value = azurerm_availability_set.AVSLINUX
}
output "vm_linux_hostname_output" {
  value = values(azurerm_linux_virtual_machine.VMLINUX)[*].computer_name
}
output "vm_linux_fqdn_output" {
  value = values(azurerm_public_ip.PIPLINUX)[*].fqdn
}
output "vm_linux_private_ip_output" {
  value = values(azurerm_linux_virtual_machine.VMLINUX)[*].private_ip_address
}
output "vm_linux_public_ip_output" {
  value = values(azurerm_linux_virtual_machine.VMLINUX)[*].public_ip_address
}
output "vm_linux_ids_output" {
  value = { for k, vm in azurerm_linux_virtual_machine.VMLINUX : k => vm.id }
}
output "vm_linux_nic_ids_output" {
  value = { for k, nic in azurerm_network_interface.NICLINUX : k => nic.id }
}