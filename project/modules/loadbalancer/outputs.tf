output "lb_output" {
  value = azurerm_lb.LB
}
output "lbfqdn_output" {
  value = azurerm_public_ip.PIPLB.fqdn
}