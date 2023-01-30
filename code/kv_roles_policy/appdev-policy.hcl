# List, create, update, and delete key/value secrets
path "secret/+/appdev-kv/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
# Create, read, and update secrets engines
path "sys/mounts/*"
{
  capabilities = ["create", "read", "update"]
}
# Read existing secrets engines.
path "sys/mounts"
{
  capabilities = ["read"]
}