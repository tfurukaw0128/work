terraform {
  required_providers {
    ciscoise = {
      source = "CiscoISE/ciscoise"
      version = "0.6.22-beta"
    }
  }
}

data "terraform_remote_state" "status" {
  backend = "remote"

  config = {
    organization = "Terraform-Cloud-ISE"
    workspaces = {
      name = "policy_create"
    }
  }
}

provider "ciscoise" {
  username = data.terraform_remote_state.status.outputs.ciscoise_username
  password = data.terraform_remote_state.status.outputs.ciscoise_password
  base_url = data.terraform_remote_state.status.outputs.ciscoise_base_url
  ssl_verify = "false"
  single_request_timeout = 150
}

resource "ciscoise_network_access_authorization_rules" "example" {
  provider = ciscoise
  parameters {

    policy_id = data.terraform_remote_state.status.outputs.policy_set_id_value
    profile   = ["PermitAccess"]
    rule {

      condition {

        condition_type  = "ConditionAttributes"
        attribute_name  = "Name"
        attribute_value = "Endpoint Identity Groups:MAB-Endpoints"
        dictionary_name = "IdentityGroup"
        operator        = "equals"
      }
    default    = "false"
    hit_counts = 0
    name       = "MAB Endpoints"
    rank       = 0
    state      = "enabled"
    }
  }
}

