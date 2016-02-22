# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :mandioca, Mandioca.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "1Umk6bdDd2yNnUkGQNX/5NCJgBXTyfE/sLs1lBsUm4xpCa7oToGMiYl73S0glCwp",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Mandioca.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: false,
  binary_id: true

config :mandioca, Mandioca.Influx,
  hosts:  [ "localhost" ],
  pool:   [ max_overflow: 0, size: 1 ],
  port:   8086,
  scheme: "http",
  writer: Instream.Writer.Line
