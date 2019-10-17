defmodule Workpermit.Permits.Permit do
  use Ecto.Schema
  import Ecto.Changeset
  alias Workpermit.Permits.ProtectiveEquipment
  alias Workpermit.Accounts.User

  schema "permits" do
    field :category, :integer
    field :number, :integer
    field :start, :naive_datetime
    field :closed, :naive_datetime
    field :finish, :naive_datetime
    field :issued, :naive_datetime
    belongs_to :issuer, User
    belongs_to :controller, User
    belongs_to :firewatch, User
    belongs_to :performer, User
    belongs_to :protective_equipment, ProtectiveEquipment

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
    ])
    |> cast_assoc(:protective_equipment, required: true)
    |> validate_required([
      :category,
      #:number,
      :issued,
      :start,
      :finish,
    ])
  end
end
