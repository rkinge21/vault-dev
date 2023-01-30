vault {
  address = "http://10.0.0.12:8200"
  token = "s.SiWwHGcTgnLNf2FvnYvXABry.pkqZG"
  namespace = "01-d7444a96-13cf-4d00-a226-c9c4a2437533"
  unwrap_token = false
  renew_token = false
}

syslog {
  enabled = true
  facility = "LOCAL5"
}

template {
  source      = "/root/python-demo-app/src/consul-agent-templates/demo-app-crt.tpl"
  destination = "/root/python-demo-app/src/certs/ca_chain.pem"
  perms       = "0600"
  create_dest_dirs = true
  command     = "/root/python-demo-app/src/restart.sh"
  wait {
     min = "2s"
     max = "10s"
  }
}

template {
  source      = "/root/python-demo-app/src/consul-agent-templates/demo-app-key.tpl"
  destination = "/root/python-demo-app/src/certs/server.key"
  perms       = "0600"
  create_dest_dirs = true
  wait {
     min = "2s"
     max = "10s"
  }
}

