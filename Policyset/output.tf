output "policy_set_id" {
  value = ciscoise_network_access_policy_set.example.id
}

output "policy_set_id_value" {
  value = substr(ciscoise_network_access_policy_set.example.id, 4, 36)
}
