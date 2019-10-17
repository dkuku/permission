defmodule Workpermit.Permits.ProtectiveEquipment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Workpermit.Permits.Permit

  # embedded_schema is short for:
  #
  #   @primary_key {:id, :binary_id, autogenerate: true}
  #   schema "embedded Item" do
  #
  schema "protective_equipment" do
    field  :ear_protection           , :boolean
    field  :earth_terminal           , :boolean
    field  :eye_protection           , :boolean
    field  :face_shield              , :boolean
    field  :foot_protection          , :boolean
    field  :head_protection          , :boolean
    field  :high_visibility_clothing , :boolean
    field  :mask                     , :boolean
    field  :safety_harness           , :boolean
    field  :welding_mask             , :boolean
    field  :protective_gloves        , :boolean
    field  :protective_clothing      , :boolean
  end

  def changeset(protective_equipment, attrs \\ %{}) do
    protective_equipment
    |> cast(attrs, [
      :ear_protection,
      :earth_terminal,
      :eye_protection,
      :face_shield,
      :foot_protection,
      :head_protection,
      :high_visibility_clothing,
      :mask,
      :safety_harness,
      :welding_mask,
      :protective_gloves,
      :protective_clothing,
    ])
    |> validate_required([])
  end
end
