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
      add :precautions, :text
      add :additional_info, :text
      add :lone_working, :bool
      add :coshh, :bool
      add :protective_equipment_value, references(:protective_equipment)
      add :issuer_id, references(:users)
      add :firewatch_id, references(:users)
      add :performer_id, references(:users)
      add :controller_id, references(:users)
      timestamps()
    end
  end
end
