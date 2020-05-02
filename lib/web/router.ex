defmodule Web.Router do
  use Web, :router
  use Pow.Phoenix.Router
  use Plug.ErrorHandler
  use Sentry.Plug
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html", "pdf"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
 #   plug Web.CSPHeader
    plug :put_secure_browser_headers
    plug Web.Plugs.Locale
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end
  pipeline :pdf do
    plug Web.PdfGenerator, orientation: 'portrait'
  end
  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    get "/", Web.PageController, :index

    pow_routes()
  end

  scope "/", Web do
    pipe_through [:browser, :protected, :pdf]
    get "/permits/pdf/:id", PermitController, :show, as: "print"
    get "/permits/pdf", PermitController, :index, as: "print"
  end
  scope "/", Web do
    pipe_through [:browser, :protected]
    # User registration and sessions
    resources "/users", UserController
    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
    delete "/sign-out", SessionController, :delete

    resources "/permits", PermitController, only: [:index, :new, :create, :show, :delete]
    get "/live", LiveController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Web do
    pipe_through :api
    post "/permits/select_category", ApiController, :select_category
    post "/users/find", UserController, :find_name
  end

  if Mix.env() == :dev do
    scope "/" do
    pipe_through :browser
    live_dashboard "/dashboard", metrics: Web.Telemetry
    get "/demo", Web.PageController, :demo
  end
  end
end
