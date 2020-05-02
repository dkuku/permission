defmodule Workpermit.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, name: Workpermit.PubSub},
      Workpermit.Repo,
      Web.Telemetry,
      Web.Endpoint
      # Starts a worker by calling: Workpermit.Worker.start_link(arg)
      # {Workpermit.Worker, arg},
    ]

    opts = [strategy: :one_for_one, name: Workpermit.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
