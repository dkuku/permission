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
    |> Ecto.Changeset.cast(attrs, [:first_name, :last_name, :phone])
    |> Ecto.Changeset.validate_required([:first_name, :last_name, :phone])
  end

  def find_names(name) do
    search(User, name)
                  |> select([u], fragment("concat(?, ' ', ?)", u.first_name, u.last_name))
                  |> limit(10)
                  |> Repo.all()
  end

  @spec search(Ecto.Query.t(), any()) :: Ecto.Query.t()
  def search(query, search_name) do
   where(
      query,
      fragment(
        "to_tsvector('english', first_name || ' ' || coalesce(last_name, ' ')) @@
        to_tsquery(?)",
        ^prefix_search(search_name)
      )
    )
  end
  defp prefix_search(term), do: String.replace(term, ~r/\W/u, "") <> ":*"
end
