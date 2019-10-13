defmodule Workpermit.Repo.Migrations.CreateProtectiveEquipmentValue do
  use Ecto.Migration

  def change do
    create table(:protective_equipment) do
      add  :ear_protection           , :boolean
      add  :earth_terminal           , :boolean
      add  :eye_protection           , :boolean
      add  :face_shield              , :boolean
      add  :foot_protection          , :boolean
      add  :head_protection          , :boolean
      add  :high_visibility_clothing , :boolean
      add  :mask                     , :boolean
      add  :safety_harness           , :boolean
      add  :welding_mask             , :boolean
      add  :protective_gloves        , :boolean
      add  :protective_clothing      , :boolean
    end
  end
end

