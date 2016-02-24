# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :estimator, Estimator.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "MnkPJ8C74/7ryAQcxpFQlEdrInQe/wy+OHnS7X5qlfJSxS5EDHcLNrZyy6KGlMR7",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Estimator.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  config :ueberauth, Ueberauth,
    providers: [
      github: { Ueberauth.Strategy.Github, [] },
    ]


config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "d1723405c7bbedcbf9ff",
  client_secret: "ab549c93f262028ad264c3277ab019fe0cb0179a"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
