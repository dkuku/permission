defmodule Web.PermitTenantController do
  use Web, :controller
  action_fallback(Web.FallbackController)
  plug :authenticate when action in [:index, :new, :create, :show]

  alias Workpermit.PermitsTenant
  alias Workpermit.Permits.Permit
  require Ecto.Query

  def index(conn, params, tenant, _user) do
    result =
      Turbo.Ecto.turbo(
        Permit,
        params,
        entry_name: "permits",
        prefix: tenant
      )

    conn
    |> assign(:permits, result.permits)
    |> assign(:paginate, result.paginate)
    |> render(:index)

    #    permits = Permits.list_permits()
    #    render(conn, "index.html", permits: permits)
  end

  def new(conn, _params, _tenant, user) do
    conn
    |> assign(:changeset, PermitsTenant.change_permit())
    |> assign(:pe, PermitsTenant.pe_fields())
    |> assign(:categories, PermitsTenant.category_fields())
    |> assign(:current_user, user)
    # use choosen category from settings
    |> assign(:choosen_category, PermitsTenant.choosen_category(:general))
    |> render("new.html")
  end

  def create(conn, %{"permit" => permit_params}, tenant, user) do
    with {:ok, permit} <- PermitsTenant.create_permit(user, tenant, permit_params) do
      conn
      |> put_flash(:info, gettext("Permit created successfully"))
      |> redirect(to: Routes.permit_path(conn, :show, permit))
    end
  end

  def show(conn, %{"id" => id}, tenant, _user) do
    with permit <- PermitsTenant.get_permit!(id, tenant) do
      render(conn, "show.html", permit: permit)
    end
  end

  def select_category(conn, %{"category" => category}) do
    choosen_category = PermitsTenant.choosen_category(category)
    json(conn, choosen_category)
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, gettext("You must be logged in to access this page"))
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def action(conn, _) do
    args = [
      conn,
      conn.params,
      Triplex.to_prefix(conn.assigns.current_tenant),
      conn.assigns.current_user
    ]

    apply(__MODULE__, action_name(conn), args)
  end
end
