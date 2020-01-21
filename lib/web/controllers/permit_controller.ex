defmodule Web.PermitController do
  use Web, :controller
  action_fallback(Web.FallbackController)
  plug :authenticate when action in [:index, :new, :create, :show]
  #plug :authenticate when action  not in [:select_category]

  alias Workpermit.Permits
  alias Workpermit.Permits.{Permit, ProtectiveEquipment}
  require Ecto.Query

  def index(conn, params, _user) do
    result = Permit 
             |> Turbo.Ecto.turbo(params, [entry_name: "permits"])
             #|> Ecto.Query.order_by(desc: :id)
    render(conn, :index, permits: result.permits, paginate: result.paginate)
#    permits = Permits.list_permits()
#    render(conn, "index.html", permits: permits)
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
    with{:ok, permit} <- Permits.create_permit(user, permit_params) do
        conn
        |> put_flash(:info, gettext("Permit created successfully"))
        |> redirect(to: Routes.permit_path(conn, :show, permit, pe: Permits.pe_fields()))
    end
  end

  def show(conn, %{"id" => id}, _user) do
    with permit <- Permits.get_permit!(id) do
      render(conn, "show.html", permit: permit, pe: Permits.pe_fields())
    end
  end

  def select_category(conn, %{"category" => category}) do
    choosen_category =  Permits.choosen_category(category)
    json(conn, choosen_category)
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      IO.puts("auth")
      conn
    else
      IO.puts("unauth")
      conn
      |> put_flash(:error, gettext("You must be logged in to access this page"))
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end
end
