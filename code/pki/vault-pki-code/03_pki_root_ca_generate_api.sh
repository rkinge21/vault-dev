#!/bin/sh
set -o xtrace
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

rm -rf certs/
mkdir -p certs/pki_root
mkdir -p certs/pki_int
mkdir -p certs/server

echo -e "\n------------------    Disable PKI Secret Engine   --------------------"

vault secrets disable pki
sleep 2


echo -e "\n------------------    Enable Vault PKI secret engine   --------------------" 
curl -s -k -H "X-Vault-Token: $VAULT_TOKEN" --request POST --data '{"type":"pki"}' $VAULT_ADDR/v1/sys/mounts/pki


echo -e "\n------------------    Set default ttl for CA to 10 years  --------------------"
curl -s -k -H "X-Vault-Token: $VAULT_TOKEN" --request POST --data '{"max_lease_ttl":"87600h"}' $VAULT_ADDR/v1/sys/mounts/pki/tune

echo -e "\n------------------    Generate root CA   --------------------"

tee payload.json <<EOF
{
  "common_name": "root-ca.com",
  "issuer_name": "Rahul-Kinge-Root-CA",
  "ttl": "87600h"
}
EOF

curl -s -k -H "X-Vault-Token: $VAULT_TOKEN" \
   --request POST \
   --data @payload.json \
   $VAULT_ADDR/v1/pki/root/generate/internal | jq -r . > certs/pki_root/pki-ca-root.json


echo -e "\n------------------    Save the certificate in a sepearate file, we will add it later as trusted to our browser/computer   --------------------"
cat certs/pki_root/pki-ca-root.json | jq -r .data.certificate > certs/pki_root/ca.crt

echo -e "\n------------------    Publish urls for the root ca   --------------------"
tee payload-url.json <<EOF
{
  "issuing_certificates": "$VAULT_ADDR/v1/pki/ca",
  "crl_distribution_points": "$VAULT_ADDR/v1/pki/crl"
}
EOF

curl -s --header "X-Vault-Token: $VAULT_TOKEN" \
   --request POST --data @payload-url.json \
   $VAULT_ADDR/v1/pki/config/urls | jq -r .




echo -e "\n------------------     List issuer info   --------------------"
curl -s  --header "X-Vault-Request: true" \
    --header "X-Vault-Token: $VAULT_TOKEN" \
    http://127.0.0.1:8200/v1/pki/issuers\?list=true | jq -r .


echo -e "\n------------------     Read issuer info   --------------------"
curl -s --header "X-Vault-Token: $VAULT_TOKEN" \
    --header "X-Vault-Request: true" \
    $VAULT_ADDR/v1/pki/issuer/7b5d0ac0-38b4-4d67-6f81-a2c39b50cc1d | jq -r .

