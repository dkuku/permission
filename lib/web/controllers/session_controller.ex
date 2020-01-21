defmodule Web.SessionController do
  use Web, :controller
  alias Workpermit.Users

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => auth_params}) do
    case Users.get_by_credentials(auth_params) do
      :error ->
        conn
        |> put_flash(:info, gettext("There was a problem with your username/password"))
        |> render("new.html")

      user ->
        conn
        |> assign(:user, user)
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> put_flash(:info, gettext("Signed in successfully"))
        |> redirect(to: Routes.permit_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> clear_session
    |> put_flash(:info, gettext("Signed out successfully"))
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
