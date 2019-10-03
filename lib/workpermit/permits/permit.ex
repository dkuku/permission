defmodule Workpermit.Permits.Permit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "permits" do
    field :category, :integer
    field :closed, :naive_datetime
    field :controller_id, :string
    field :finish, :naive_datetime
    field :issued, :naive_datetime
    field :issuer_id, :string
    field :number, :integer
    field :performer_id, :string
    embeds_one :protective_equipment_value, ProtectiveEquipment
    field :start, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(permit, attrs) do
    permit
    |> cast(attrs, [
      :category,
      :number,
      :issued,
      :start,
      :finish,
      :closed,
      :issuer_id,
      :performer_id,
      :controller_id
    ])
    |> cast_embed(:protective_equipment_value)
    |> validate_required([
      :category,
      :number,
      :issued,
      :start,
      :finish,
      :closed,
      :issuer_id,
      :performer_id,
      :controller_id
    ])
  end
end
