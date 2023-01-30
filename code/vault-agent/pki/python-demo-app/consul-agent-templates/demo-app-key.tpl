{{ with secret "pki_int_v1/issue/demo-app" "common_name=localhost" "alt_names=richard.corporate.demo,rahul.corporate.demo"  "ttl=15m" }}
{{ .Data.private_key }}
{{ end }}

