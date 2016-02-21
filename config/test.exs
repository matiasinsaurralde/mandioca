use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mandioca, Mandioca.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :mandioca, Mandioca.Repo,
  adapter: Mongo.Ecto,
  database: "mandioca_test",
  pool_size: 1
