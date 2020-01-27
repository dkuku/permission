use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :workpermit, Web.Endpoint,
  http: [port: 4001],
  server: true

config :hound, driver: "phantomjs"

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :workpermit, Workpermit.Repo,
  username: "postgres",
  password: "postgres",
  database: "workpermit_test",
  hostname: System.get_env("DB_HOST", "localhost"),
  pool: Ecto.Adapters.SQL.Sandbox
