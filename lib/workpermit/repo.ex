defmodule Workpermit.Repo do
  use Ecto.Repo,
    otp_app: :workpermit,
    adapter: Ecto.Adapters.Postgres
end
