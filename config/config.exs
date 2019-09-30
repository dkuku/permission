# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :workpermit,
  ecto_repos: [Workpermit.Repo]

# Configures the endpoint
config :workpermit, WorkpermitWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "V8vj221j4H6PdMpZps8Ldk6ztUxn4Z/H1Hwdg9H7mFGODMWwWo5jhbqbQHuL1BI2",
  render_errors: [view: WorkpermitWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Workpermit.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :workpermit, WorkpermitWeb.Gettext, default_locale: "en", locales: ~w(en pl de)
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
