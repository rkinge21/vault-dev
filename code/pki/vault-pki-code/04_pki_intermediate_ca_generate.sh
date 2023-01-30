#!/bin/sh
set -o xtrace
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

echo -e "\n------------------    Disable pki secret engine for intermediate CA   --------------------"
vault secrets disable pki_int
sleep 2

echo -e "\n------------------    Enable pki secret engine for intermediate CA   --------------------"
vault secrets enable -path=pki_int pki

echo -e "\n------------------    Set default ttl for Intermediate CA to 5 years    --------------------"
vault secrets tune -max-lease-ttl=43800h pki_int

echo -e "\n------------------    Create intermediate CA and save the CSR (Certificate Signing Request) in a seperate file   --------------------"
vault write -format=json pki_int/intermediate/generate/internal \
        common_name="intermediate-ca.com" \
        issuer_name="Rahul-Kinge-Intermediate-CA" \
        | jq -r '.data.csr' > certs/pki_int/pki_intermediate.csr

echo -e "\n------------------    Send the intermediate CA's CSR to the root CA for signing   --------------------"
#save the generated certificate in a sepearate file         
vault write -format=json pki/root/sign-intermediate \
        issuer_ref="Rahul-Kinge-Root-CA" \
        csr=@certs/pki_int/pki_intermediate.csr \
        format=pem_bundle ttl="43800h" \
        | jq -r '.data.certificate' > certs/pki_int/intermediate.cert.crt


echo -e "\n------------------    Publish the signed certificate back to the Intermediate CA   --------------------"
vault write pki_int/intermediate/set-signed certificate=@certs/pki_int/intermediate.cert.crt


echo -e "\n------------------    Publish the intermediate CA urls   --------------------"
vault write pki_int/config/urls \
     issuing_certificates="$VAULT_ADDR/v1/pki_int/ca" \
     crl_distribution_points="$VAULT_ADDR/v1/pki_int/crl"

