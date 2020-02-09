defmodule Workpermit.Permits.Permit do
  use Ecto.Schema
  import Ecto.Changeset
  alias Workpermit.Users.User
  import EctoEnum

  defenum(CategoryEnum,
    general: 0,
    electrical: 1,
    heights: 2,
    hot_work: 3,
    confined_space: 4,
    hot_fluid: 5,
    gas: 6
  )

  @protective_equipment [
    :ear_protection,
    :earth_terminal,
    :eye_protection,
    :face_shield,
    :foot_protection,
    :head_protection,
    :high_visibility_clothing,
    :dust_mask,
    :protective_clothing,
    :protective_gloves,
    :safety_harness,
    :welding_mask
  ]
  def protective_equipment() do
    @protective_equipment
    |> Enum.map(&to_string(&1))
  end

  schema "permits" do
    field :category, CategoryEnum
    field :number, :integer
    field :start_time, :naive_datetime
    field :closed_time, :naive_datetime
    field :finish_time, :naive_datetime
    field :issued_time, :naive_datetime
    field :organisation, :integer
    field :issuer_name, :string
    field :controller_name, :string
    field :firewatch_name, :string
    field :performer_name, :string
    field :precautions, Permits.Precautions
    field :additional_info, :string
    field :coshh, :boolean
    field :lone_working, :boolean
    field :protective_equipment, {:array, :string}
    belongs_to :issuer, User

    timestamps()
  end

  @doc false
  def changeset(permit, attrs) do
    permit
    |> cast(attrs, [
      :category,
      :issuer_id,
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
      :organisation,
      :protective_equipment
    ])
    |> validate_required([
      :category,
      :start_time
    ])
    |> validate_subset(:protective_equipment, protective_equipment())
  end
end
