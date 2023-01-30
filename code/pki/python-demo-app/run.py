import os
from app import create_app

app = create_app()

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 443))
    app.jinja_env.auto_reload = True
    app.config["TEMPLATES_AUTO_RELOAD"] = True
    # app.run(host="0.0.0.0", port=port)
    app.run(host="0.0.0.0", port=port, ssl_context=('certs/test.hub.com.crt', 'certs/test.hub.com.key'))
