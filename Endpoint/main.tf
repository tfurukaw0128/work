terraform {
  required_providers {
    ciscoise = {
      source = "CiscoISE/ciscoise"
      version = "0.7.0-beta"
    }
  }
}
provider "ciscoise" {
  username = "admin"
  password = "C1sco12345!"
  base_url = "https://10.71.130.8"
  debug = "true"
  ssl_verify = "false"
  use_api_gateway = "false"
  use_csrf_token = "false"
  single_request_timeout = 150
}

data "terraform_remote_state" "id" {
  backend = "remote"

  config = {
    organization = "Terraform-Cloud-ISE"
    workspaces = {
      name = "groupid_create"
    }
  }
}

resource "ciscoise_endpoint" "example" {
  provider = ciscoise
  parameters {

    group_id          = data.terraform_remote_state.id.outputs.ciscoise_endpoint_group_id
    mac               = "11:22:33:44:55:66"
    name                      = "11:22:33:44:55:66"
    static_group_assignment   = "true"
    static_profile_assignment = "false"
  }
}
