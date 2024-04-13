resource "azurerm_network_interface" "NICLINUX" {
  for_each            = var.vm_linux_name
  name                = "${each.key}-nic"
  resource_group_name = var.rg_name
  location            = var.location
  tags                = local.common_tags
  ip_configuration {
    name                          = "${each.key}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.PIPLINUX[each.key].id
  }
}
resource "azurerm_public_ip" "PIPLINUX" {
  for_each            = var.vm_linux_name
  name                = "${each.key}-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Dynamic"
  domain_name_label   = each.key
  tags                = local.common_tags
}
resource "azurerm_linux_virtual_machine" "VMLINUX" {
  for_each            = var.vm_linux_name
  name                = each.key
  computer_name       = each.key
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.size_linux
  admin_username      = var.admin_username_linux
  availability_set_id = azurerm_availability_set.AVSLINUX.id
  tags                = local.common_tags
  network_interface_ids = [
    azurerm_network_interface.NICLINUX[each.key].id
  ]
  admin_ssh_key {
    username   = var.admin_username_linux
    public_key = file(var.public_key)
  }
  os_disk {
    name                 = "${each.key}-disk"
    caching              = var.os_disk_attr_linux.caching
    storage_account_type = var.os_disk_attr_linux.storage_acct_type
  }
  source_image_reference {
    publisher = var.os_info_linux.publisher
    offer     = var.os_info_linux.offer
    sku       = var.os_info_linux.sku
    version   = var.os_info_linux.version
  }
  plan {
    name      = var.os_info_linux.offer
    publisher = var.os_info_linux.publisher
    product   = var.os_info_linux.sku
  }
}
resource "azurerm_availability_set" "AVSLINUX" {
  name                         = var.avs_linux
  resource_group_name          = var.rg_name
  location                     = var.location
  platform_update_domain_count = "5"
  platform_fault_domain_count  = "2"
  tags                         = local.common_tags
}