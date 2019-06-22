# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :purlex, PurlexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6an/66UtrIziKo/2Z2xOQxstnXhq89US+qRHG+00whopQRkXMcWmMM11a1KIZT7M",
  render_errors: [view: PurlexWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Purlex.PubSub, adapter: Phoenix.PubSub.PG2]

config :phoenix_active_link, :defaults,
  class_active: "nav-link active",
  class_inactive: "nav-link"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
