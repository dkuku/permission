defmodule Workpermit.ProtectiveEquipment do
  @moduledoc """
  The ProtectiveEquipment context.
  """

  import Ecto.Query, warn: false
  alias Workpermit.Repo

  alias Workpermit.Permits.ProtectiveEquipment
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

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking protective_equipment changes.

  ## Examples

      iex> change_protective_equipment(protective_equipment)
      %Ecto.Changeset{source: %ProtectiveEquipment{}}

  """
  def change_protective_equipment(%ProtectiveEquipment{} = protective_equipment) do
    ProtectiveEquipment.changeset(protective_equipment, %{})
  end

  def pe_fields do
    #set it as an org param
    ProtectiveEquipment.keys()
  end
end
