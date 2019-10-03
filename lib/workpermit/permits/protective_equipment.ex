defmodule ProtectiveEquipment do
  use Ecto.Schema
  import Ecto.Changeset

  # embedded_schema is short for:
  #
  #   @primary_key {:id, :binary_id, autogenerate: true}
  #   schema "embedded Item" do
  #
  embedded_schema do
    field :hard_hat, :boolean
    field :safety_boots, :boolean
    field :safety_helmet, :boolean
    field :hivis_vest, :boolean
    field :ear_protection, :boolean
    field :eyes_protection, :boolean
  end

  def changeset(protective_equipment_value, attrs) do
    protective_equipment_value
    |> cast(attrs, [
      :ear_protection,
      :eyes_protection,
      :hard_hat,
      :hivis_vest,
      :id,
      :safety_boots,
      :safety_helmet
    ])
    |> validate_required([])
  end
end
