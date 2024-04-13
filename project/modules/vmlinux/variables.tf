locals {
  common_tags = {
    Project     = "CCGC 5501 Cloud Security Project"
    Name        = "Jemmel.Salvador"
    Environment = "Project"
  }
}
variable "rg_name" {}
variable "location" {}
variable "avs_linux" {}
variable "size_linux" {}
variable "admin_username_linux" {}
variable "public_key" {}
variable "priv_key" {}
variable "vm_linux_name" {
  type = map(string)
}
variable "os_disk_attr_linux" {
  type = map(string)
}
variable "os_info_linux" {
  type = map(string)
}
variable "subnet_id" {}