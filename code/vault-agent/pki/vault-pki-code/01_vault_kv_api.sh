
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root



curl -s
    -H "X-Vault-Token: f3b09679-3001-009d-2b80-9c306ab81aa6" \
    -H "X-Vault-Namespace: CSM" \
    -H "X-Vault-Request: true" \
    -H "Content-Type: application/json" \
    -X GET  http://127.0.0.1:8200/v1/secret/foo



#---------------------------       Vault Healthcheck-up     --------------------------------
curl --head $VAULT_ADDR/v1/sys/health
# or
curl -s -H "X-Vault-Token: $VAULT_TOKEN" --request GET  $VAULT_ADDR/v1/sys/host-info | jq -r .data.host


#---------------------------       Read KV Config :     --------------------------------
curl -s --header "X-Vault-Token: $VAULT_TOKEN" \
    $VAULT_ADDR/v1/secret/config  | jq -r .


#---------------------------       Create KV Secret :     --------------------------------
curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
    -X GET $VAULT_ADDR/v1/secret/data/baz | jq -r .


#---------------------------       Create KV Secret : V2     --------------------------------

curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
    -H "Content-Type: application/json" \
    -X POST -d '{"data":{"value":"bar"}}' $VAULT_ADDR/v1/secret/data/baz | jq -r .

curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
    -X GET $VAULT_ADDR/v1/secret/data/baz | jq -r .

curl -s -H "X-Vault-Token: $VAULT_TOKEN" \
    -X GET $VAULT_ADDR/v1/secret/data/baz?version=1 | jq -r .


#---------------------------       Read KV Config :     --------------------------------
