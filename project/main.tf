module "rgroup" {
  source   = "./modules/rgroup"
  rg_name  = "web-RG"
  location = "canadacentral"
}
module "network" {
  source       = "./modules/network"
  rg_name      = module.rgroup.rg_output.name
  location     = module.rgroup.rg_output.location
  vnet_name    = "web-VNET"
  vnet_space   = ["10.1.0.0/16"]
  subnet_name  = "web-SUBNET"
  subnet_space = ["10.1.0.0/24"]
  nsg_name     = "web-NSG"
}
module "vmlinux" {
  source               = "./modules/vmlinux"
  rg_name              = module.rgroup.rg_output.name
  location             = module.rgroup.rg_output.location
  avs_linux            = "web-AVSLINUX"
  size_linux           = "Standard_B1ms"
  admin_username_linux = "n01235433"
  public_key = "~/id_rsa.pub"
  priv_key   = "~/id_rsa"
  vm_linux_name = {
    web-vm1 = ""
    web-vm2 = ""
    web-vm3 = ""
  }
  os_disk_attr_linux = {
    storage_acct_type = "Premium_LRS"
    disk_size         = "32"
    caching           = "ReadWrite"
  }
  os_info_linux = {
    publisher = "cognosys"
    offer     = "centos-8-2-free"
    sku       = "centos-8-2-free"
    version   = "latest"
  }
  subnet_id        = module.network.subnet_output.id
}
module "loadbalancer" {
  source           = "./modules/loadbalancer"
  rg_name          = module.rgroup.rg_output.name
  location         = module.rgroup.rg_output.location
  vm_linux_nic_ids = module.vmlinux.vm_linux_nic_ids_output
  dns_label        = "web-resume"
}