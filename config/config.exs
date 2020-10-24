# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :linx,
  ecto_repos: [Linx.Repo]

# Configures the endpoint
config :linx, LinxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/5HfPDDcbOQDWHMfFemk3t2HXsnD/VchpB4qXRl69VWQyji+kzXTe+7PQCA0e+Q2",
  render_errors: [view: LinxWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Linx.PubSub,
  live_view: [signing_salt: "45DtGvFv"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :linx, Linx.Guardian,
  issuer: "linx",
  secret_key: "1vZ6fE7S8FILaQP3XnDYFlD3P58XfyIfv8Ryyvh+j6KNXWmWcVXiV+GSKys/JoJjwCo=",
  ttl: {3, :days}

config :linx, LinxWeb.AuthAccessPipeline,
  module: Linx.Guardian,
  error_handler: LinxWeb.AuthErrorHandler

config :linx, Linx.Mailer,
  adapter: Bamboo.MandrillAdapter,
  api_key: "my_api_key"

config :kaffy,
   otp_app: :linx,
   ecto_repo: Linx.Repo,
   router: LinxWeb.Router

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
