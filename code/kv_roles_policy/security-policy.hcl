# List existing policies
path "sys/policies/acl"
{
  capabilities = ["list"]
}
# Create and manage ACL policies
path "sys/policies/acl/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
# Manage secrets engines
path "sys/mounts/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
# List existing secrets engines.
path "sys/mounts"
{
  capabilities = ["read"]
}
# List, create, update, and delete key/value secrets
path "secret/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
# Deny access to secret/admin
path "secret/data/admin/*" {
    capabilities = ["deny"]
}
# Deny list access to secret/admin
path "secret/metadata/admin/*" {
    capabilities = ["deny"]
}