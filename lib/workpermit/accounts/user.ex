defmodule Workpermit.Accounts.User do
  @moduledoc """
  User model
  """
  use Ecto.Schema
  alias Workpermit.Accounts.User
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string
    field :first_name, :string
    field :last_name, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :first_name, :last_name, :phone])
    |> validate_required([:email, :password, :first_name, :last_name, :phone])
    |> unique_constraint(:email)
    |> put_hashed_password()
  end

  defp put_hashed_password(changeset) do
    case changeset.valid? do
      true -> 
        changes = changeset.changes
        put_change(changeset, :encrypted_password, Argon2.hash_pwd_salt(changes.password))
      _ ->
        changeset
    end
  end

  def build_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
  end

end
