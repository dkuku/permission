defmodule Web.ApiController do
  use Web, :controller
  alias Workpermit.Permits

  def select_category(conn, %{"category" => category}) do
    choosen_category = Permits.choosen_category(category)
    json(conn, choosen_category)
  end
end
