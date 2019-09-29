defmodule WorkpermitWeb.PageController do
  use WorkpermitWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
