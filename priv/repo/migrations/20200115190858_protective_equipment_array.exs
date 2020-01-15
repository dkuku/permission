defmodule Workpermit.Repo.Migrations.ProtectiveEquipmentArray do
  use Ecto.Migration

  def change do
    #alter type hello_type add value 'd' after 'a';
    execute "CREATE TYPE protective_equipment_enum as enum (
    'dust_mask',
    'ear_protection',
    'earth_terminal',
    'eye_protection',
    'face_shield',
    'foot_protection',
    'head_protection',
    'high_visibility_clothing',
    'protective_clothing',
    'protective_gloves',
    'safety_harness',
    'welding_mask'
    );",
    "DROP TYPE protective_equipment_enum;"
    execute(&execute_up/0, &execute_down/0)
  end

  defp execute_up do
    repo().query!(
      "ALTER TABLE permits ADD COLUMN protective_equipment protective_equipment_enum[] NOT NULL DEFAULT '{}' ;",
      [],
      [log: :info]
    )
  end
  defp execute_down do
    repo().query!(
      "ALTER TABLE permits DROP COLUMN protective_equipment;",
      [],
      [log: :info]
    )
  end
end
