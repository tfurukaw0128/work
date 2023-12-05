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

resource "ciscoise_endpoint_group" "example" {
  provider = ciscoise
  parameters {

    name           = "MAB-Endpoints"
  }
}