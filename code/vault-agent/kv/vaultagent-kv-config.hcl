pid_file = "./pidfile"

vault {
  address = "http://127.0.0.1:8200"
  retry {
    num_retries = 1
  }
}

auto_auth {
  method {
    type      = "approle"
    config = {
      role_id_file_path = "./role_id_kv"
      secret_id_file_path = "./secret_id_kv"
      remove_secret_id_file_after_reading = false
    }
  }
  sink {
    type = "file"
    config = {
      path = "token_kv"
    }
  }
  sink {
    type = "file"
    wrap_ttl = "30s"
    config = {
      path = "token_kv_wrapped"
    }
  }
}

listener "tcp" {
  address = "127.0.0.1:8100"
  tls_disable = true
}

template {
  source      = "./agent-secret-kv.ctmpl"
  destination = "./secret_kv"
}
