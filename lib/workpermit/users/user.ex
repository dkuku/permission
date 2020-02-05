defmodule Workpermit.Users.User do
  use Ecto.Schema
  import Ecto.Query, warn: false

  use Pow.Ecto.Schema,
    password_hash_methods: {&Argon2.hash_pwd_salt/1, &Argon2.verify_pass/2}

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :phone, :string

    pow_user_fields()
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> pow_changeset(attrs)
    |> Ecto.Changeset.validate_confirmation(:password)
    |> Ecto.Changeset.cast(attrs, [:first_name, :last_name, :phone])
    |> Ecto.Changeset.validate_required([:first_name, :last_name, :phone])
  end
end
