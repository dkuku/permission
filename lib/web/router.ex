defmodule Web.Router do
  use Web, :router
  use Pow.Phoenix.Router
  use Plug.ErrorHandler
  use Sentry.Plug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Web.Plugs.Locale
  end

  pipeline :tenant do
    plug Triplex.SubdomainPlug,
      endpoint: Web.Endpoint,
      assign: :current_tenant,
      tenant_handler: &Web.TenantHelper.tenant_handler/1
    plug Triplex.EnsurePlug,
      assign: :current_tenant,
      callback: &Web.TenantHelper.callback/2,
      failure_callback: &Web.TenantHelper.failure_callback/2
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through [:browser]

    get "/", Web.PageController, :index
    get "/demo", Web.PageController, :demo

  end
  scope "/" do
    pipe_through [:browser, :tenant]

    pow_routes()
  end

  scope "/", Web do
    pipe_through [:browser, :tenant, :protected]
    # User registration and sessions
    resources "/users", UserController
    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
    delete "/sign-out", SessionController, :delete

    resources "/permits", PermitController, only: [:index, :new, :create, :show]

    get "/live", LiveController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Web do
    pipe_through :api
    post "/permits/select_category", ApiController, :select_category
    post "/users/find", UserController, :find_name
  end
end
