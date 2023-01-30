#!/bin/sh
set -o xtrace
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

export VAULT_ROLE_NAME="learn_hub-role"
export VAULT_CERT_ALLOWED_DOMAIN="hub.com"

echo -e "\n------------------    Create a role to generate new certificates   --------------------"
vault write pki_int/roles/$VAULT_ROLE_NAME \
        allowed_domains="$VAULT_CERT_ALLOWED_DOMAIN" \
        allow_subdomains=true \
        max_ttl="720h"


echo -e "\n------------------    Read Role   --------------------"
vault read pki_int/roles/$VAULT_ROLE_NAME





vault write pki_int/roles/mcu-role \
    allowed_domains="mcu.com" \
    allow_subdomains=true \
    allow_bare_domains=true \
    allow_ip_sans=false \
    allow_localhost=false \
    client_flag=false \
    country="IN" \
    locality="Pune" \
    street_address="Baner Road" \
    enforce_hostnames=false \
    organization="MARVEL ORG" \
    ou="MARVEL OU" \
    postal_code="411045" \
    province="English, Hindi, Marathi" \
    require_cn=false \
    max_ttl="24h" \
    ttl="1h"

vault read pki_int/roles/mcu-role


# Delete Role
# vault delete pki_int/roles/$VAULT_ROLE_NAME

