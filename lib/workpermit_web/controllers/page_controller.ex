defmodule WorkpermitWeb.PageController do
  use WorkpermitWeb, :controller
  alias Elixilorem

  def index(conn, _params) do
    conn
    |> assign(:title, Elixilorem.words(3))
    |> assign(:body, Elixilorem.paragraph())
    |> render("index.html")
  end
end
