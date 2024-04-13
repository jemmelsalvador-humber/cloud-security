output "vnet_output" {
  value = azurerm_virtual_network.VNET
}
output "subnet_output" {
  value = azurerm_subnet.SUBNET
}
output "nsg_output" {
  value = azurerm_network_security_group.NSG
}