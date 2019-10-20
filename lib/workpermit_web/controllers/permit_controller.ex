defmodule WorkpermitWeb.PermitController do
  use WorkpermitWeb, :controller

  alias Workpermit.Permits
  alias Workpermit.Permits.Permit
  alias Workpermit.Permits.ProtectiveEquipment

  def index(conn, _params) do
    permits = Permits.list_permits()
    render(conn, "index.html", permits: permits)
  end

  def new(conn, _params) do
    conn
    |> assign(:changeset, Permits.change_permit(%Permit{protective_equipment: %ProtectiveEquipment{}}))
    |> assign(:pe, Permits.pe_fields())
    |> assign(:categories, Permits.category_fields())
    |> assign(:current_user, conn.assigns.user)
    # use choosen category from settings
    |> assign(:choosen_category, Permits.choosen_category(:general))
    |> render("new.html")
  end

  def create(conn, %{"permit" => permit_params}) do
    permit = Map.put(permit_params, "issuer_id", conn.assigns.user.id)
    case Permits.create_permit(permit) do
      {:ok, permit} ->
        conn
        |> put_flash(:info, "Permit created successfully.")
        |> redirect(to: Routes.permit_path(conn, :show, permit, pe: Permits.pe_fields()))

      {:error, %Ecto.Changeset{} = changeset} ->
        
        conn
        |> assign(:changeset, changeset)
        |> assign(:current_user, conn.assigns.user)
        |> assign(:pe, Permits.pe_fields())
        |> assign(:categories, Permits.category_fields())
        # use choosen category from changeset
        |> assign(:choosen_category, Permits.choosen_category(:general))
        |> render("new.html")
    end
  end

  def show(conn, %{"id" => id}) do
    permit = Permits.get_permit!(id)
    render(conn, "show.html", permit: permit, pe: Permits.pe_fields())
  end

  def select_category(conn, %{"category" => category}) do
    choosen_category =  Permits.choosen_category(category)
    json(conn, choosen_category)
  end
end
