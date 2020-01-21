defmodule Workpermit.Users do
  alias Workpermit.Users.User
  alias Workpermit.Repo

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
