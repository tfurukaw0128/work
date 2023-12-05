resource "ciscoise_endpoint_group" "example" {
  provider = ciscoise
  parameters {

    name           = "MAB-Endpoints"
  }
}