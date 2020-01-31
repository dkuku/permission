defmodule Workpermit.Repo.Migrations.CreatePermits do
  use Ecto.Migration

  def change do
    create table(:permits) do
      add :category, :integer
      add :number, :integer
      add :organisation, :integer
      add :issued_time, :naive_datetime
      add :start_time, :naive_datetime
      add :finish_time, :naive_datetime
      add :closed_time, :naive_datetime
      add :precautions, :text
      add :additional_info, :text
      add :lone_working, :bool
      add :coshh, :bool
      add :protective_equipment_id, references(:protective_equipment)
      add :issuer_id, references(:users)
      add :issuer_name, :string
      add :controller_name, :string
      add :firewatch_name, :string
      add :performer_name, :string
      timestamps()
    end
  end
end
