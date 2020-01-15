defmodule Workpermit.Repo.Migrations.DropProtectiveEquipment do
  use Ecto.Migration

  def up do
    alter table(:permits) do
      remove_if_exists :protective_equipment_id, references(:protective_equipment)
    end
  end
  def down, do: ""
end
