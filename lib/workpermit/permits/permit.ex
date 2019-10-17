defmodule Workpermit.Permits.Permit do
  use Ecto.Type
  use Ecto.Schema
  import Ecto.Changeset
  alias Workpermit.Permits.ProtectiveEquipment
  alias Workpermit.Accounts.User
  import EctoEnum

  defenum CategoryEnum, general: 0, electrical: 1, heights: 2, hot_work: 3, confined_space: 4, hot_fluid: 5, gas: 6

  schema "permits" do
    field :category, CategoryEnum
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
