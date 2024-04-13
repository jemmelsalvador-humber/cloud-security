locals {
  common_tags = {
    Project     = "CCGC 5501 Cloud Security Project"
    Name        = "Jemmel.Salvador"
    Environment = "Project"
  }
}
variable "rg_name" {}
variable "location" {}