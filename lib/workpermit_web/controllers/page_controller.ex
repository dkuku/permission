defmodule WorkpermitWeb.PageController do
  use WorkpermitWeb, :controller
  plug :put_layout, "landing.html"
  alias Elixilorem
  def index(conn, _params) do
    conn
    |> assign(:title, Elixilorem.words(3))
    |> assign(:body, Elixilorem.paragraph())
    |> assign(:time, Timex.today())
    |> render("index.html")
  end
end
