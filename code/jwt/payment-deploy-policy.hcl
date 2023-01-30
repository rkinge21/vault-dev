# This allows the user to read "secrets/services/payment/stripe"
# with a parameter named "token" and can contain any value.
path "secrets/services/payment/mysecret" {
  capabilities = [ "read" ]
}
path "secrets/gcp/gke/production/payment/deploy_sa" {
  capabilities = [ "read" ]
}