terraform {
  required_providers {
    ciscoise = {
      source = "CiscoISE/ciscoise"
      version = "0.6.22-beta"
    }
  }
}
provider "ciscoise" {
  username = var.ciscoise_username
  password = var.ciscoise_password
  base_url = var.ciscoise_base_url
  ssl_verify = "false"
  single_request_timeout = 150
}