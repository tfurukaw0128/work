output "ciscoise_endpoint_group_id" {
  value = substr(ciscoise_endpoint_group.example.id, 4, 36)
}