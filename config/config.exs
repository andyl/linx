import Config

config :linx, LinxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6an/66UtrIziKo/2Z2xOQxstnXhq89US+qRHG+00whopQRkXMcWmMM11a1KIZT7M",
  render_errors: [view: LinxWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Linx.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "SECRETKEYWORD"]

config :phoenix_active_link, :defaults,
  class_active: "nav-link active",
  class_inactive: "nav-link"

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
