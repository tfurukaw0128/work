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
