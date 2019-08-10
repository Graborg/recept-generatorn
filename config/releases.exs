import Config

secret_key_base = System.fetch_env!("SECRET_KEY_BASE")
application_port = "4000"

config :recept_generatorn, ReceptGeneratornWeb.Endpoint,
  http: [:inet6, port: String.to_integer(application_port)],
  secret_key_base: secret_key_base

config(:recept_generatorn, ReceptGeneratorn.Repo,
  username: "postgres",
  password: "postgres",
  database: "recept_generatorn_dev",
  hostname: "postgres"
)
