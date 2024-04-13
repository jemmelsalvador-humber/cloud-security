locals {
  common_tags = {
    Project     = "CCGC 5501 Cloud Security Project"
    Name        = "Jemmel.Salvador"
    Environment = "Project"
  }
}
variable "rg_name" {}
variable "location" {}
variable "vnet_name" {}
variable "vnet_space" {}
variable "subnet_name" {}
variable "subnet_space" {}
variable "nsg_name" {}