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
      {:argon2_elixir, "~> 2.0"},
      {:comeonin, "~> 5.2"},
      {:distillery, "~> 2.1"},
      {:db_connection, "~> 2.1", override: true},
      {:earmark, "~> 1.4"},
      {:ecto_enum, github: "dnsbty/ecto_enum", ref: "a69a9dde72cf98497606f9603bd46e3924979145"},
      {:ecto, "~> 3.3", override: true},
      {:ecto_sql, "~> 3.0"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:pdf_generator, ">=0.4.0"},
      {:phoenix, "~> 1.4.12", override: true},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_form_awesomplete, "~> 0.1"},
      {:phoenix_html, "~> 2.14"},
      {:phoenix_pubsub, "~> 1.1"},
      {:plug_cowboy, "~> 2.0"},
      {:postgrex, ">= 0.0.0"},
      {:pow, github: "danschultzer/pow", ref: "master"},
      {:timex, "~> 3.5"},
      {:triplex, "~> 1.3.0"},
      #{:turbo_ecto, "~> 0.4.1"},
      {:turbo_ecto, github: "redmar/turbo_ecto", ref: "134e517"},
      {:turbo_html, github: "dkuku/turbo_html", ref: "b515e2e"},
      {:sentry, "~> 7.0"},
      {:sobelow, "~> 0.8", only: [:dev]},
      # {:turbo_html, path: "../turbo_html"},
      {:excoveralls, "~> 0.10", only: [:test]},
      {:ex_machina, "~> 2.3", only: [:test]},
      { :changex, "~> 0.2.0"},
      # {:faker, "~> 0.13", only: [:dev, :test]},
      {:faker, "~> 0.13"},
      {:cabbage, "~> 0.3.0", only: [:test]},
      {:hound, github: "HashNuke/hound", ref: "0613a33f065a1eaa91fab602b8bc9af367d78ec1" },
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, github: "phoenixframework/phoenix_live_view", override: true},
      {:floki, ">= 0.0.0", only: :test},
      {:surface, git: "https://github.com/msaraiva/surface.git"},
      {:phoenix_live_dashboard, "~> 0.1"},
      {:telemetry_poller, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},
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
