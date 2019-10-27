defmodule Workpermit.Permits do
  @moduledoc """
  The Permits context.
  """

  import Ecto.Query, warn: false
  alias Workpermit.Repo
  alias Ecto

  alias Workpermit.Permits.Permit
  alias Workpermit.Permits.ProtectiveEquipment
  alias Workpermit.Accounts
  @doc """
  Returns the list of permits.

  ## Examples

      iex> list_permits()
      [%Permit{}, ...]

  """
  def list_permits do
    Repo.all(Permit)
  end

  @doc """
  Gets a single permit.

  Raises `Ecto.NoResultsError` if the Permit does not exist.

  ## Examples

      iex> get_permit!(123)
      %Permit{}

      iex> get_permit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_permit!(id) do
    Repo.one from permit in Permit,
      where: permit.id == ^id,
      preload: :protective_equipment,
      preload: :issuer
  end

  def get_permit(id) do
    {:ok, permit} = get_permit!(id)
    permit
  end
  @doc """
  Creates a permit.

  ## Examples

      iex> create_permit(%{field: value})
      {:ok, %Permit{}}

      iex> create_permit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_permit(%Accounts.User{} = user, attrs \\ %{}) do
    %Permit{}
    |> Permit.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:issuer, user)
    |> Repo.insert()
  end

  @doc """
  Deletes a Permit.

  ## Examples

      iex> delete_permit(permit)
      {:ok, %Permit{}}

      iex> delete_permit(permit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_permit(%Permit{} = permit) do
    Repo.delete(permit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking permit changes.

  ## Examples

      iex> change_permit(permit)
      %Ecto.Changeset{source: %Permit{}}

  """
  def change_permit(%Permit{} = permit) do
    Permit.changeset(permit, %{})
  end
  
  @doc """
  Returns an `%Ecto.Changeset{}` for tracking protective_equipment changes.

  ## Examples

      iex> change_protective_equipment(protective_equipment)
      %Ecto.Changeset{source: %Protective_equipment{}}

  """
  def change_protective_equipment(%ProtectiveEquipment{} = protective_equipment) do
    ProtectiveEquipment.changeset(protective_equipment, %{})
  end

  @doc """
  Gets a single protective_equipment.

  Raises `Ecto.NoResultsError` if the ProtectiveEquipment does not exist.

  ## Examples

      iex> get_protective_equipment(123)
      %ProtectiveEquipment{}

      iex> get_protective_equipment(456)
      ** (Ecto.NoResultsError)

  """
  def get_protective_equipment(id), do: Repo.get!(ProtectiveEquipment, id)

  @doc """
  Creates a protective_equipment.

  ## Examples

      iex> create_protective_equipment(%{field: value})
      {:ok, %ProtectiveEquipment{}}

      iex> create_protective_equipment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_protective_equipment(attrs \\ %{}) do
    %ProtectiveEquipment{}
    |> ProtectiveEquipment.changeset(attrs)
    |> Repo.insert()
    #|>Repo.find_or_create_by(:name)
  end

  @doc """
  Deletes a ProtectiveEquipment.

  ## Examples

      iex> delete_protective_equipment(protective_equipment)
      {:ok, %ProtectiveEquipment{}}

      iex> delete_protective_equipment(protective_equipment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_protective_equipment(%ProtectiveEquipment{} = protective_equipment) do
    Repo.delete(protective_equipment)
  end

  def category_fields do
    Permit.CategoryEnum.__enum_map__() |> Enum.map(fn {k, _} -> k end)
  end

  def pe_fields do
    #set it as an org param
    ProtectiveEquipment.keys()
  end

  @doc """
  ## Examples
      iex(19)> Workpermit.Permits.next_permit_number(3)
      14
      iex(20)> Workpermit.Permits.next_permit_number(4)
      1
  """
  def next_permit_number(category) do
    last_number = Repo.one from permit in Permit,
                    where: permit.category == ^category,
                    select: max(permit.number)
    (last_number || 0) + 1
  end

  def image(category) when is_atom(category) do
    %{:general => :general_warning_sign,
    :electrical => :electricity_hazard,
    :heights => :drop_or_fall_hazard,
    :hot_work => :flammable_material,
    :confined_space => :confined_space,
    :hot_fluid => :hot_surface,
    :gas => :pressurized_cylinder }
    |> Map.fetch!(category)
  end

  def image(category) when is_bitstring(category), do: image(String.to_atom(category))

  @doc """
      iex(1)> Workpermit.Permits.choosen_category(:hot_work)
      %{image: "/iso/ISO_7010_W021.svg", next_number: 15, selected: :hot_work}
  """
  def choosen_category(category) do
    %{
      next_number: next_permit_number(category),
      image: Workpermit.IsoSymbols.symbol_to_image_path(image(category)),
      selected: category,
    }
  end

  def default_precautions do
    [
    "### General rules",
    "Have you been given a copy of the Site Safety Rules?",
    "Has a risk assessment been carried out?",
    "Are the workforce qualified to carry out the task?",
    "Is appropriate PPE available?",
    "Is safe access and egress confirmed?",
    ]
  end

  def default_confined_space do
    [
    "### Confined space rules",
    "Are personnel trained and supplied With Breathing Apparatus?",
    "Lifebelt and rope held on outside of confined space?",
    ]
  end

  def default_hot_work do
    [
    "### Hot work rules",
    "Are at least two fire extinguishers available?",
    "Are personnel trained in use of fire extinguishers?",
    "Have flammable liquids/materials been removed from area?",
    "Have Gas cylinders been properly secured?",
    ]
  end

  def default_heights do
    [
    "### Working on heights rules",
    "Is work carried out at height?",
    "Are ladders or scaffolding required?",
    "Is a license required and in place for scaffolding?",
    "Are personel aware and of means of escape and method of raising alarm?",
    "Risk of falling objects?",
    "Details of fragile roof explained?",
    ]
  end

  def default_electrical do
    [
    "Isolated electrical supply? Work in accordance with current Electricity at Work regs?",
    "Isolator locked off/tagged? Work in accordance with I.E.E. Wiring regs.",
    "Is voltage detection instrument required?",
    ]
  end
  
  def default_coshh do
    [
    "Has COSHH data been supplied with substances?",
    "Have COSHH precautions been identified and implemented?",
    ]
  end

end
