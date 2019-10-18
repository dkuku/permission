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
    field :start_time, :naive_datetime
    field :closed_time, :naive_datetime
    field :finish_time, :naive_datetime
    field :issued_time, :naive_datetime
    belongs_to :issuer, User
    field :organisation, :integer
    field :issuer_name, :string
    field :controller_name, :string
    field :firewatch_name, :string
    field :performer_name, :string
    field :precautions, :string
    field :additional_info, :string
    field :coshh, :boolean
    field :lone_working, :boolean

    belongs_to :protective_equipment, ProtectiveEquipment

    timestamps()
  end

  @doc false
  def changeset(permit, attrs) do
    permit
    |> cast(attrs, [
      :category,
      :number,
      :issued_time,
      :start_time,
      :finish_time,
      :closed_time,
      :issuer_name,
      :performer_name,
      :controller_name,
      :firewatch_name,
      :precautions,
      :additional_info,
      :coshh,
      :lone_working,
      :organisation
    ])
    |> cast_assoc(:protective_equipment, required: true)
    #|> cast_assoc(:issuer, required: true)
    |> validate_required([
      :category,
      #:number,
      :issued_time,
      :start_time,
      :finish_time,
    ])
  end
end
