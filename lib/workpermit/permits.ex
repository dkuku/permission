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
  def get_permit!(id), do: Repo.get!(Permit, id)

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
#    |> Repo.insert()
    IO.inspect(attrs)
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
  Returns an `%Ecto.Changeset{}` for tracking protective_equipment_value changes.

  ## Examples

      iex> change_protective_equipment_value(protective_equipment_value)
      %Ecto.Changeset{source: %Protective_equipment_value{}}

  """
  def change_protective_equipment_value(%ProtectiveEquipment{} = protective_equipment_value) do
    ProtectiveEquipment.changeset(protective_equipment_value, %{})
  end
end
