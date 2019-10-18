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
    |> render("new.html")
  end

  def create(conn, %{"permit" => permit_params}) do
    case Permits.create_permit(permit_params) do
      {:ok, permit} ->
        conn
        |> put_flash(:info, "Permit created successfully.")
        |> redirect(to: Routes.permit_path(conn, :show, permit, pe: Permits.pe_fields()))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, pe: Permits.pe_fields())
    end
  end

  def show(conn, %{"id" => id}) do
    permit = Permits.get_permit!(id)
    render(conn, "show.html", permit: permit, pe: Permits.pe_fields())
  end
end
