defmodule Web.FallbackController do
  use Web, :controller
  alias Workpermit.Permits

  def call(conn, {:error, msg}, _user) when is_binary(msg) do
    conn
    |> put_flash(:error, msg)
    |> redirect(to: Routes.permit_path(conn, :index))
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}, user) do
    conn
    |> assign(:changeset, changeset)
    |> assign(:current_user, user)
    |> assign(:pe, Permits.pe_fields())
    |> assign(:categories, Permits.category_fields())
    # use choosen category from changeset
    |> assign(:choosen_category, Permits.choosen_category(:general))
    |> put_flash(:error, get_msg(conn))
    |> render("new.html")
  end

  defp get_msg(conn) do
    name = action_name(conn)
    Map.get(error_msgs(), name, "There was an issue")
  end

  defp error_msgs do
    %{create: "There was an issue creating the permit"}
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.user]
    apply(__MODULE__, action_name(conn), args)
  end
end
