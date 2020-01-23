# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :recept_generatorn,
  ecto_repos: [ReceptGeneratorn.Repo]

# Configures the endpoint
config :recept_generatorn, ReceptGeneratornWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "27yumxdGi1rvj3tryhmTq/1x4W9n9AA0ixpvMyczZy5aEFhREw+ALAwaC7ofKkxG",
  render_errors: [view: ReceptGeneratornWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ReceptGeneratorn.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "Q2BIDgnlqSqsICAIutYV6wG7yDDziwc0l8bqldfWqCDa4ySewY/t4WZoPYW7uiNe"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix,
  json_library: Jason,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
