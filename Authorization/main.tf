data "terraform_remote_state" "status" {
  backend = "remote"

  config = {
    organization = "Terraform-Cloud-ISE"
    workspaces = {
      name = "policyset_create"
    }
  }
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

