defmodule Web.LiveController do
  use Web, :controller
  alias Phoenix.LiveView

  def index(conn, _params) do
    LiveView.Controller.live_render(conn, Web.RacerView, session: %{})
  end
end
