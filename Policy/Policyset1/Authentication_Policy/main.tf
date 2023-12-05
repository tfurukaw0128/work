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
      name = "policyset_create"
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

resource "ciscoise_network_access_authentication_rules" "example" {
  provider = ciscoise
  parameters {
    identity_source_name = "Internal Endpoints"
    if_auth_fail         = "REJECT"
    if_user_not_found    = "REJECT"
    if_process_fail      = "DROP"

    policy_id = data.terraform_remote_state.status.outputs.policy_set_id_value
    rule {

      condition {

        condition_type  = "ConditionAttributes"
        attribute_name  = "RadiusFlowType"
        attribute_value = "WiredMAB"
        dictionary_name = "Normalised Radius"
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

