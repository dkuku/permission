defmodule Web do
  def controller do
    quote do
      use Phoenix.Controller, namespace: Web

      import Plug.Conn
      import Web.Gettext
      alias Web.Router.Helpers, as: Routes
      import Phoenix.LiveView.Controller
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/web/templates",
        pattern: "**/*",
        namespace: Web

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      import Phoenix.LiveView.Helpers

      import Surface
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import Web.ErrorHelpers
      import Web.Gettext
      alias Gettext, as: OrgGettext
      alias Web.Router.Helpers, as: Routes
      import Web.Helpers.Auth, only: [signed_in?: 1]
      import Web.Helpers.Forms
      import Turbo.HTML
      use Timex
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import Web.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
