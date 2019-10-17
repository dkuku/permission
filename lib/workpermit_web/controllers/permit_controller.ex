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
    |> assign(:pe, pe_fields())
    |> assign(:categories, Permit.CategoryEnum.__enum_map__() |> Enum.map(fn {k, _} -> k end))
    |> render("new.html")
  end

  def create(conn, %{"permit" => permit_params}) do
    case Permits.create_permit(permit_params) do
      {:ok, permit} ->
        conn
        |> put_flash(:info, "Permit created successfully.")
        |> redirect(to: Routes.permit_path(conn, :show, permit, pe: pe_fields()))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, pe: pe_fields())
    end
  end

  def show(conn, %{"id" => id}) do
    permit = Permits.get_permit!(id)
    render(conn, "show.html", permit: permit, pe: pe_fields())
  end

  def pe_fields do
    #set it as an org param
    [
      :ear_protection,
      :earth_terminal,
      :eye_protection,
      :face_shield,
      :foot_protection,
      :head_protection,
      :high_visibility_clothing,
      :mask,
      :safety_harness,
      :welding_mask,
      :protective_gloves,
      :protective_clothing,
    ]
  end
end
