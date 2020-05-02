defmodule Workpermit.UsersTenant do
  alias Workpermit.Users.User
  alias Workpermit.Repo

  @doc """
  Returns the list of users.
  ## Examples
      iex> list_users()
      [%User{}, ...]
  """
  def list_users(tenant \\ nil), do: Repo.all(User, prefix: tenant)

  @doc """
  Gets a single user.
  Raises `Ecto.NoResultsError` if the User does not exist.
  ## Examples
      iex> get_user!(123)
      %User{}
      iex> get_user!(456)
      ** (Ecto.NoResultsError)
  """
  def get_by_email(nil), do: nil
  def get_by_email(nil, _tenant), do: nil
  def get_by_email(email, tenant), do: Repo.get_by(User, email: email, prefix: tenant)

  def get_user!(id, tenant \\ nil), do: Repo.get!(User, id, prefix: tenant)

  def get_by_credentials(%{"email" => email, "password" => password}) do
    get_by_credentials(%{email: email, password: password}, nil)
  end

  def get_by_credentials(%{"email" => email, "password" => password}, nil) do
    get_by_credentials(%{email: email, password: password}, nil)
  end

  def get_by_credentials(%{"email" => email, "password" => password}, tenant) do
    get_by_credentials(%{email: email, password: password}, tenant)
  end

  def get_by_credentials(%{email: email, password: password}, tenant) when is_nil(tenant) do
    user = get_by_email(email)

    if user && Argon2.verify_pass(password, user.password_hash) do
      user
    else
      :error
    end
  end

  def get_by_credentials(%{email: email, password: password}, tenant) do
    user = get_by_email(email, tenant)

    if user && Argon2.verify_pass(password, user.password_hash) do
      user
    else
      :error
    end
  end

  @doc """
  Creates a user.
  ## Examples
      iex> create_user(%{field: value})
      {:ok, %User{}}
      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_user(attrs \\ %{}, tenant \\ nil) do
    attrs
    |> build_user
    |> Repo.insert(prefix: tenant)
  end

  def build_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
  end

  @doc """
  Updates a user.
  ## Examples
      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}
      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_user(%User{} = user, attrs, tenant \\ nil) do
    user
    |> User.changeset(attrs)
    |> Repo.update(prefix: tenant)
  end

  @doc """
  Deletes a User.
  ## Examples
      iex> delete_user(user)
      {:ok, %User{}}
      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}
  """
  def delete_user(%User{} = user, tenant \\ nil) do
    Repo.delete(user, prefix: tenant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  ## Examples
      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}
  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
