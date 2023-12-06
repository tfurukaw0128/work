data "terraform_remote_state" "status" {
  backend = "remote"

  config = {
    organization = "Terraform-Cloud-ISE"
    workspaces = {
      name = "policyset_create"
    }
  }
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
      name       = "MAB"
      rank       = 0
      state      = "enabled"
    }
  }
}

