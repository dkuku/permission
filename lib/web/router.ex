defmodule Web.Router do
  use Web, :router
  use Plug.ErrorHandler
  use Sentry.Plug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Web.Plugs.LoadUser
    plug Web.Plugs.Locale

  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Web do
    pipe_through :browser

    get "/", PageController, :index
    get "/demo", PageController, :demo

    # User registration and sessions
    resources "/users", UserController
    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
    delete "/sign-out", SessionController, :delete

    resources "/permits", PermitController, only: [:index, :new, :create, :show]
  end

  # Other scopes may use custom stacks.
  scope "/api", Web do
    pipe_through :api
    post "/permits/select_category", ApiController, :select_category
    post "/users/find", UserController, :find_name
  end
end