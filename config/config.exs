# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :workpermit,
  ecto_repos: [Workpermit.Repo]

config :turbo_ecto, Turbo.Ecto,
  repo: Workpermit.Repo,
  per_page: 10

# config :turbo_html, Turbo.HTML,
#  view_style: :custom

# Configures the endpoint
config :workpermit, Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "V8vj221j4H6PdMpZps8Ldk6ztUxn4Z/H1Hwdg9H7mFGODMWwWo5jhbqbQHuL1BI2",
  render_errors: [view: Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Workpermit.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "E7S7f1RciqnSlS7ylHCCTGxXRrpVhS/a"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :logger, Sentry.LoggerBackend, include_logger_metadata: true

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :workpermit, Web.Gettext, default_locale: "en", locales: ~w(en pl de)

config :sentry,
  dsn: "https://aea562a06208474f9cc0e6ce4e45773f@sentry.io/1823262",
  environment_name: Mix.env(),
  root_source_code_path: File.cwd!(),
  tags: %{
    env: "production"
  },
  enable_source_code_context: true,
  included_environments: [:prod]

config :workpermit, :pow,
  user: Workpermit.Users.User,
  repo: Workpermit.Repo,
  web_module: Web

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
