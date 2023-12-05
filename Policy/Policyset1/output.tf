output "ciscoise_username" {
  value = var.ciscoise_username
}

output "ciscoise_password" {
  value = var.ciscoise_password
}

output "ciscoise_base_url" {
  value = var.ciscoise_base_url
}

output "policy_set_id" {
  value = ciscoise_network_access_policy_set.example.id
}

output "policy_set_id_value" {
  value = substr(ciscoise_network_access_policy_set.example.id, 4, 36)
}
