defmodule WorkpermitWeb.PermitController do
  use WorkpermitWeb, :controller
  plug :authenticate

  alias Workpermit.Permits
  alias Workpermit.Permits.Permit
  alias Workpermit.Permits.ProtectiveEquipment

  def index(conn, _params, _user) do
    permits = Permits.list_permits()
    render(conn, "index.html", permits: permits)
  end

  def new(conn, _params, user) do
    conn
    |> assign(:changeset, Permits.change_permit(%Permit{protective_equipment: %ProtectiveEquipment{}}))
    |> assign(:pe, Permits.pe_fields())
    |> assign(:categories, Permits.category_fields())
    |> assign(:current_user, user)
    # use choosen category from settings
    |> assign(:choosen_category, Permits.choosen_category(:general))
    |> render("new.html")
  end

  def create(conn, %{"permit" => permit_params}, user) do
    case Permits.create_permit(user, permit_params) do
      {:ok, permit} ->
        conn
        |> put_flash(:info, gettext("Permit created successfully."))
        |> redirect(to: Routes.permit_path(conn, :show, permit, pe: Permits.pe_fields()))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> assign(:changeset, changeset)
        |> assign(:current_user, user)
        |> assign(:pe, Permits.pe_fields())
        |> assign(:categories, Permits.category_fields())
        # use choosen category from changeset
        |> assign(:choosen_category, Permits.choosen_category(:general))
        |> render("new.html")
    end
  end

  def show(conn, %{"id" => id}, _user) do
    permit = Permits.get_permit!(id)
    render(conn, "show.html", permit: permit, pe: Permits.pe_fields())
  end

  def select_category(conn, %{"category" => category}, _user) do
    choosen_category =  Permits.choosen_category(category)
    json(conn, choosen_category)
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.user do
      conn
    else
      conn
      |> put_flash(:error, gettext("You must be logged in to access this page"))
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.user]
    apply(__MODULE__, action_name(conn), args)
  end
end
