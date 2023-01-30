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
vault secrets enable pki

echo -e "\n------------------    Set default ttl for CA to 10 years  --------------------"
vault secrets tune -max-lease-ttl=87600h pki

echo -e "\n------------------    Generate root CA   --------------------"
vault write -format=json pki/root/generate/internal \
     common_name="root-ca.com" \
     issuer_name="Rahul-Kinge-Root-CA" \
     ttl=87600h > certs/pki_root/pki-ca-root.json


echo -e "\n------------------    Save the certificate in a sepearate file, we will add it later as trusted to our browser/computer   --------------------"
cat certs/pki_root/pki-ca-root.json | jq -r .data.certificate > certs/pki_root/ca.crt

echo -e "\n------------------    Publish urls for the root ca   --------------------"
vault write pki/config/urls \
        issuing_certificates="$VAULT_ADDR/v1/pki/ca" \
        crl_distribution_points="$VAULT_ADDR/v1/pki/crl"


echo -e "\n------------------     List issuer info   --------------------"
vault list pki/issuers/
