defmodule Web.UserController do
  use Web, :controller

  alias Workpermit.Users

  def find_name(conn, %{"name" => name}) do
    users = Users.find_names(name)
    json(conn, users)
  end
end
