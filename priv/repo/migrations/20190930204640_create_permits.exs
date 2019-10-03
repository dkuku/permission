defmodule Workpermit.Repo.Migrations.CreatePermits do
  use Ecto.Migration

  def change do
    create table(:permits) do
      add :category, :integer
      add :number, :integer
      add :issued, :naive_datetime
      add :start, :naive_datetime
      add :finish, :naive_datetime
      add :closed, :naive_datetime
      add :protective_equipment_value, :map
      add :issuer_id, :string
      add :performer_id, :string
      add :controller_id, :string

      timestamps()
    end
  end
end
