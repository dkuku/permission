defmodule WorkpermitWeb.PageController do
  use WorkpermitWeb, :controller
  plug :put_layout, "landing.html"
  def index(conn, _params) do
    conn
    |> assign(:time, Timex.today())
    |> render("index.html")
  end
end
