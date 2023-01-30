# First of all we are going to start Vault in development mode
vault server -dev

# Now set your Vault address environment variable
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN="root"
vault login root

# And log into Vault using the root token
vault login root 

# First let's see what auth methods are avilable now
vault auth list

# Cool, now let's enable our first auth method using userpass
vault auth enable userpass

# Now let's check the list of auth methods again
vault auth list


cd /e/Tutorials/Vault/VaultWork/code/kv_roles_policy

#-------------------------------        Create Policies       -------------------------------#
vault policy list

# Create the admin / appdev/ security  policies
vault policy write admin-policy    admin-policy.hcl
vault policy write appdev-policy   appdev-policy.hcl
vault policy write security-policy security-policy.hcl
vault policy list


#-------------------------------        Create Users       -------------------------------#
# Start by creating a few different users with different policies:
vault write auth/userpass/users/admin    password="admin123"    policies="admin-policy"
vault write auth/userpass/users/appdev   password="appdev123"   policies="appdev-policy"
vault write auth/userpass/users/security password="security123" policies="security-policy"



#-------------------------------        Create secrets       -------------------------------#

# Create some secrets in the secret/security path:
vault kv put secret/security-kv/first username=password
vault kv put secret/security-kv/second username=password

# Create some secrets in the secret/appdev path:
vault kv put secret/appdev-kv/first username=password
vault kv put secret/appdev-kv/beta-app/second username=password

# Create some secrets in the secret/admin path:
vault kv put secret/admin-kv/first admin=password
vault kv put secret/admin-kv/supersecret/second admin=password



#-------------------------------        Verification       -------------------------------#
# Verify security for appdev
vault login -method="userpass" username="appdev" password="appdev123"
export VAULT_TOKEN="hvs.CAESIE1Huqgcm7KCysb7BUEwq12CYF7xFWf4CO0WTIoXF_mTGh4KHGh2cy41SDlhT0lRa2hWdE1mNkswckNncmYxSnk"
vault login hvs.CAESIOiuzsi9YzJazKfFelaAYNgCXs97Opx54zAkNnEAfG-WGh4KHGh2cy5mVm1IZ0J2THNBQ3ZweU5Va0JMcXJ0U3I

vault kv get secret/appdev-kv/first                             # Should work
vault kv get secret/appdev-kv/beta-app/second                   # Should work



# Create a new secret:
vault kv put secret/appdev-kv/appcreds credentials=creds123     # Should work

# Destroy the secret:
vault kv destroy -versions=1 secret/appdev-kv/appcreds          # Should work


# Attempt to get a secret from secret/security:
vault kv get secret/security-kv/first
    #   Error reading secret/data/security/first: Error making API request.
    #   URL: GET http://127.0.0.1:8200/v1/secret/data/security/first
    #   Code: 403. Errors:
    #   * 1 error occurred:
    #           * permission denied


vault kv list secret/
    #   Error reading secret/data/security/first: Error making API request.
    #   URL: GET http://127.0.0.1:8200/v1/secret/metadata?list=true
    #   Code: 403. Errors:
    #   * 1 error occurred:
    #           * permission denied



path "secret/data/security-kv/*"
{
  capabilities = ["read", "list"]
}

vault kv put secret/security-kv/appcreds credentials=creds123