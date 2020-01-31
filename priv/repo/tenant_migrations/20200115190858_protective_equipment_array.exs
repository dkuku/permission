defmodule Workpermit.Repo.Migrations.ProtectiveEquipmentArrayColumn do
  use Ecto.Migration

  def up do
    repo().query!(
      "ALTER TABLE #{prefix()}.permits ADD COLUMN protective_equipment protective_equipment_enum[] NOT NULL DEFAULT '{}' ;",
      [],
      log: :info
    )
  end

  def down do
    repo().query!(
      "ALTER TABLE #{prefix()}.permits DROP COLUMN protective_equipment;",
      [],
      log: :info
    )
  end
end
