terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}
provider "vault" {
  address = "http://127.0.0.1:8200"
  skip_child_token = true
  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id = var.vault_role_id
      secret_id = var.vault_secret_id
    }
  }
}
data "vault_kv_secret_v2" "example" {
  mount = "secret" // mount
  name = "test-secret" // secret
}