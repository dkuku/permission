defmodule WorkpermitWeb.Plugs.LoadUser do
  import Plug.Conn
  alias Workpermit.Accounts
  def init(_opts), do: nil

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Accounts.get_user!(user_id)
    assign(conn, :user, user)
  end
end
