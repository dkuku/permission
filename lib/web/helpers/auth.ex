defmodule Web.Helpers.Auth do
  @moduledoc """
  Helpers to use with authentication
  """
  def signed_in?(conn) do
    user_id = Plug.Conn.get_session(conn, :user_id)
    if user_id, do: !!Workpermit.Repo.get(Workpermit.Users.User, user_id)
  end
end
