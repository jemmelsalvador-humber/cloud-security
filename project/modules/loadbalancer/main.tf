resource "azurerm_public_ip" "PIPLB" {
  name                = "PIPLB"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  domain_name_label   = var.dns_label
  tags                = local.common_tags
}
resource "azurerm_lb" "LB" {
  name                = "LOADBALANCE"
  resource_group_name = var.rg_name
  location            = var.location
  tags                = local.common_tags
  frontend_ip_configuration {
    name                 = "LBIPCONFIG"
    public_ip_address_id = azurerm_public_ip.PIPLB.id
  }
}
resource "azurerm_lb_backend_address_pool" "LBBE" {
  name            = "LBBE"
  loadbalancer_id = azurerm_lb.LB.id
}
resource "azurerm_network_interface_backend_address_pool_association" "LBASSOC" {
  for_each                = var.vm_linux_nic_ids
  network_interface_id    = each.value
  ip_configuration_name   = "${each.key}-ipconfig"
  backend_address_pool_id = azurerm_lb_backend_address_pool.LBBE.id
}
resource "azurerm_lb_probe" "LBPROBE" {
  loadbalancer_id = azurerm_lb.LB.id
  name            = "LBPROBE"
  port            = 80
}
resource "azurerm_lb_rule" "LBRULE" {
  loadbalancer_id                = azurerm_lb.LB.id
  name                           = "LBRULE"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.LB.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.LBBE.id]
  probe_id                       = azurerm_lb_probe.LBPROBE.id
}