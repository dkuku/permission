options = [
  exclude: [:skip]
]

ExUnit.start(options)
Ecto.Adapters.SQL.Sandbox.mode(Workpermit.Repo, :manual)
{:ok, _} = Application.ensure_all_started(:ex_machina)
