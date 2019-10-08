import Config

secret_key_base = 
  "ASDFASDFASDFASDFASDFASDFASDFASDFASDFASDFASDFASDFASDFASDFASDFASDFASDFASDFASDF"

config :linkex, LinkexWeb.Endpoint,
  url: [host: "example.com", port: 5050],
  http: [:inet6, port: 5050],
  secret_key_base: secret_key_base,
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true

config :logger, level: :info

