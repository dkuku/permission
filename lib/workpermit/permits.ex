defmodule Workpermit.Permits do
  @moduledoc """
  The Permits context.
  """

  import Ecto.Query, warn: false
  alias Workpermit.Repo

  alias Workpermit.Permits.Permit
  alias Workpermit.Permits.ProtectiveEquipment
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
      preload: :protective_equipment
  end

  @doc """
  Creates a permit.

  ## Examples

      iex> create_permit(%{field: value})
      {:ok, %Permit{}}

      iex> create_permit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_permit(attrs \\ %{}) do
    %Permit{}
    |> Permit.changeset(attrs)
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
end
