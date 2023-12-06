resource "ciscoise_network_access_policy_set" "example" {
  provider = ciscoise
  parameters {
    default      = "false"
    description  = "test policy set"
    hit_counts   = 0
    name         = "test-policyset"
    rank         = 0
    service_name = "Default Network Access"
    state        = "enabled"

    condition {
      condition_type = "ConditionAttributes"
      attribute_name  = "RadiusFlowType"
      attribute_value = "WiredMAB"
      dictionary_name = "Normalised Radius"
      operator        = "equals"
    }
  }
}