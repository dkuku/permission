defmodule WorkpermitWeb.PermitController do
  use WorkpermitWeb, :controller

  alias Workpermit.Permits
  alias Workpermit.Permits.Permit

  def index(conn, _params) do
    permits = Permits.list_permits()
    render(conn, "index.html", permits: permits)
  end

  def new(conn, _params) do
    changeset = Permits.change_permit(%Permit{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"permit" => permit_params}) do
    case Permits.create_permit(permit_params) do
      {:ok, permit} ->
        conn
        |> put_flash(:info, "Permit created successfully.")
        |> redirect(to: Routes.permit_path(conn, :show, permit))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    permit = Permits.get_permit!(id)
    render(conn, "show.html", permit: permit)
  end
end
