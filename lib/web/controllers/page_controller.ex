defmodule Web.PageController do
  use Web, :controller
  plug :put_layout, "landing.html"

  def index(conn, _params) do
    conn
    |> render("index.html")

  end

  def demo(conn, _params) do
    conn
    |> assign(:time, Timex.today())
    |> render("demo.html", isosymbols: Workpermit.Permits.IsoSymbols)
  end
end
