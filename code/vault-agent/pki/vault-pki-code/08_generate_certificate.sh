#!/bin/sh
set -o xtrace
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root


export VAULT_ROLE_NAME="learn_hub-role"
export VAULT_CERT_NAME="test.hub.com"
export VAULT_CERT_SAN1_NAME="rahul.hub.com"
export VAULT_CERT_SAN2_NAME="kinge.hub.com"


#set roleid and secretid as env variables from the previous step
export VAULT_USER="rahul"
export VAULT_PASSWORD="kinge"

vault login -format=json -method=userpass \
    username=${VAULT_USER} \
    password=${VAULT_PASSWORD} | jq -r .auth.client_token > user.token

#store the token as env variable, now this token can be used to authenticate against Vault
export VAULT_TOKEN=`cat user.token`


echo -e "\n------------------    Read Role   --------------------"
vault read pki_int/roles/$VAULT_ROLE_NAME


echo -e "\n------------------    Request Certificates   --------------------"
vault write -format=json pki_int/issue/$VAULT_ROLE_NAME \
    common_name="$VAULT_CERT_NAME" \
    alt_names="$VAULT_CERT_SAN1_NAME,$VAULT_CERT_SAN2_NAME" \
    ttl="3h" > certs/server/$VAULT_CERT_NAME.json

echo -e "\n------------------    extract the certificate, issuing ca in the pem file and private key in the key file seperately   --------------------"
cat certs/server/$VAULT_CERT_NAME.json | jq -r .data.certificate > certs/server/$VAULT_CERT_NAME.crt
cat certs/server/$VAULT_CERT_NAME.json | jq -r .data.issuing_ca >> certs/server/$VAULT_CERT_NAME.crt
cat certs/server/$VAULT_CERT_NAME.json | jq -r .data.private_key > certs/server/$VAULT_CERT_NAME.key





# Request Certificates :
vault write -format=json pki_int/issue/mcu-role \
    common_name="avengers.mcu.com" \
    alt_names="ironman.mcu.com,captain.mcu.com" \
    ttl="3h" > certs/server/avengers.mcu.com.json

#extract the certificate, issuing ca in the pem file and private key in the key file seperately
cat certs/server/avengers.mcu.com.json | jq -r .data.certificate > certs/server/avengers.mcu.com.crt
cat certs/server/avengers.mcu.com.json | jq -r .data.issuing_ca >> certs/server/avengers.mcu.com.crt
cat certs/server/avengers.mcu.com.json | jq -r .data.private_key > certs/server/avengers.mcu.com.key

