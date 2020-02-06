defmodule Web.UserTenantController do
  use Web, :controller

  alias Workpermit.UsersTenant
  alias Workpermit.Users.User

  def index(conn, _params, tenant) do
    users = UsersTenant.list_users(tenant)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params, _tenant) do
    changeset = UsersTenant.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}, tenant) do
    case UsersTenant.create_user(user_params, tenant) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> assign(:user, user)
        |> configure_session(renew: true)
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.permit_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, tenant) do
    user = UsersTenant.get_user!(id, tenant)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}, tenant) do
    user = UsersTenant.get_user!(id, tenant)
    changeset = UsersTenant.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}, tenant) do
    user = UsersTenant.get_user!(id)

    case UsersTenant.update_user(user, user_params, tenant) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, _tenant) do
    user = UsersTenant.get_user!(id)
    {:ok, _user} = UsersTenant.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end

  #def find_name(conn, %{"name" => name}, _tenant) do
  #  users = UsersTenant.find_names(name)
  #  json(conn, users)
  #end

  def action(conn, _) do
    args = [conn, conn.params, Triplex.to_prefix(conn.assigns.current_tenant)]
    apply(__MODULE__, action_name(conn), args)
  end
end
