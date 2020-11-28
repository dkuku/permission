defmodule Workpermit.MixProject do
  use Mix.Project

  def project do
    [
      app: :workpermit,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Workpermit.Application, []},
      extra_applications: [:logger, :runtime_tools, :timex]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # {:faker, "~> 0.13", only: [:dev, :test]},
      # {:turbo_ecto, "~> 0.4.1"},
      # {:turbo_html, path: "../turbo_html"},
      {:argon2_elixir, "~> 2.0"},
      {:cabbage, "~> 0.3.0", only: [:test]},
      {:changex, "~> 0.2.0"},
      {:comeonin, "~> 5.2"},
      {:db_connection, "~> 2.1", override: true},
      {:distillery, "~> 2.1"},
      {:earmark, "~> 1.4"},
      {:ecto, "~> 3.3", override: true},
      {:ecto_enum, github: "gjaldon/ecto_enum"},
      {:ecto_sql, "~> 3.0"},
      {:ex_machina, "~> 2.3", only: [:test]},
      {:excoveralls, "~> 0.10", only: [:test]},
      {:faker, "~> 0.13"},
      {:floki, ">= 0.0.0", only: :test},
      {:gettext, "~> 0.11"},
      {:hound, github: "HashNuke/hound", ref: "0613a33f065a1eaa91fab602b8bc9af367d78ec1"},
      {:jason, "~> 1.0"},
      {:pdf_generator, ">=0.4.0"},
      {:phoenix, "~> 1.5.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_form_awesomplete, "~> 0.1"},
      {:phoenix_html, "~> 2.14"},
      {:phoenix_live_dashboard, github: "phoenixframework/phoenix_live_dashboard"},

      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, github: "phoenixframework/phoenix_live_view", override: true},
      {:phoenix_pubsub, "~> 2.0"},
      {:plug_cowboy, "~> 2.1"},
      {:postgrex, ">= 0.0.0"},
      {:pow, "~> 1.0.20"},
      {:sentry, "~> 7.0"},
      {:sobelow, "~> 0.8", only: [:dev]},
      {:surface, github: "msaraiva/surface"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:timex, "~> 3.5"},
      {:triplex, "~> 1.3.0"},
      {:turbo_ecto, github: "redmar/turbo_ecto", ref: "134e517"},
      {:turbo_html, github: "dkuku/turbo_html", ref: "b515e2e"},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.seed_env": ["run priv/repo/seeds.#{Mix.env()}.exs"],
      "ecto.seed": ["run priv/repo/seeds.exs"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
