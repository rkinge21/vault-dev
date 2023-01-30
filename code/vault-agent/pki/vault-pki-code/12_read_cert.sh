#!/bin/sh
set -o xtrace
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

cert1=$(sed '3q;d' cert_key_list)
echo $cert1

#read certificate 
vault read  pki_int/cert/${cert1}


curl --header "X-Vault-Token: $VAULT_TOKEN" \
	--header "X-Vault-Namespace: $VAULT_NAMESPACE" \
    --request LIST  $VAULT_ADDR/v1/pki_int/certs


# Total Count of Certificates
curl -s --header "X-Vault-Token: $VAULT_TOKEN" \
	--header "X-Vault-Namespace: $VAULT_NAMESPACE" \
    --request LIST  $VAULT_ADDR/v1/pki_int/certs

# Get 2nd Cert
curl -s --header "X-Vault-Token: $VAULT_TOKEN" \
    --header "X-Vault-Namespace: $VAULT_NAMESPACE" \
    --request LIST  $VAULT_ADDR/v1/pki_int/certs | jq '.data.keys[1]'

curl -s --header "X-Vault-Token: $VAULT_TOKEN" \
    --header "X-Vault-Namespace: $VAULT_NAMESPACE" \
    --request LIST  $VAULT_ADDR/v1/pki_int/certs | jq -r '.data.keys[1]'


vault read  pki_int/cert/01-c1-90-30-f4-cf-04-ba-e4-e5-e7-e8-f2-0e-4a-9f-b3-bd-87-bf -format=json

vault read  pki_int/cert/01-c1-90-30-f4-cf-04-ba-e4-e5-e7-e8-f2-0e-4a-9f-b3-bd-87-bf -format=json | jq -r .data.certificate
