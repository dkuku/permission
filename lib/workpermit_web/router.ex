defmodule WorkpermitWeb.Router do
  use WorkpermitWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug WorkpermitWeb.Plugs.LoadUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WorkpermitWeb do
    pipe_through :browser

    get "/", PageController, :index

    # User registration and sessions
    resources "/users", UserController
    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
    delete "/sign-out", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", WorkpermitWeb do
  #   pipe_through :api
  # end
end
