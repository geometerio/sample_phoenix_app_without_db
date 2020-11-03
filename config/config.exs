# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :sample_phoenix_app_without_db, SamplePhoenixAppWithoutDbWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TRyEYbltaJlex5GMbxQ9akxooyXGS8SpA+KQaKD/hx8H42VFPmZ9mUum5mC6QJYk",
  render_errors: [view: SamplePhoenixAppWithoutDbWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SamplePhoenixAppWithoutDb.PubSub,
  live_view: [signing_salt: "O4fvXDNo"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
