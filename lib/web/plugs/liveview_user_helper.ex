defmodule Web.LiveViewUserHelper do
  @moduledoc """
  Handle pow user in LiveView.

  This will use three keys:

  * `:user` the user struct or `nil`.
  * ':authenticated` `true` if `:user` is authenticated. Will be set to false
  once the session times out.
  * `:timer` reference for the interval timer

      defmodule LendingWeb.SomeViewLive do
        use PhoenixLiveView
        use LendingWeb.AuthHelper, otp_app: lending

        def mount(session, socket) do
          socket = current_user(socket, session)
          …
        end
        
        def handle_info(:session_ttl_hit, socket) do
          …
        end

        handle_auth_ttl(no_longer_authenticated_info: :session_ttl_hit)
      end
  """

  defmacro __using__(opts) do
    otp_app = Keyword.fetch!(opts, :otp_app)

    session_key = "#{otp_app}_auth"

    backend =
      Keyword.get_lazy(opts, :backend, fn ->
        Application.get_env(otp_app, :pow, [])
        |> Keyword.get(:cache_store_backend, Pow.Store.Backend.EtsCache)
      end)

    interval = Keyword.get(opts, :interval, :timer.seconds(60))

    config = %{
      backend: backend,
      session_key: session_key,
      interval: interval
    }

    quote do
      import unquote(__MODULE__)
      @config unquote(Macro.escape(config))
    end
  end

  defmacro current_user(socket, session) do
    quote do
      socket =
        unquote(socket)
        |> assign(@config.session_key, Map.fetch!(unquote(session), @config.session_key))

      socket =
        case user_from_session(Map.fetch!(socket.assigns, @config.session_key), @config.backend) do
          {:ok, user} ->
            socket
            |> assign(:current_user, user)
            |> assign(:authenticated, true)

          :not_found ->
            socket
            |> assign(:current_user, nil)
            |> assign(:authenticated, false)
        end

      socket =
        if Phoenix.LiveView.connected?(socket) do
          {:ok, ref} = :timer.send_interval(@config.interval, self(), :pow_auth_ttl)
          assign(socket, :timer, ref)
        else
          socket
        end

      socket
    end
  end

  defmacro handle_auth_ttl(opts \\ []) do
    msg = Keyword.get(opts, :no_longer_authenticated_info, nil)

    quote do
      def handle_info(:pow_auth_ttl, socket) do
        require Logger

        Logger.info("Check if user is still valid")

        case user_from_session(Map.fetch!(socket.assigns, @config.session_key), @config.backend) do
          {:ok, user} ->
            socket =
              socket
              |> assign(:current_user, user)
              |> assign(:authenticated, true)

            {:noreply, socket}

          :not_found ->
            :timer.cancel(socket.assigns.timer)

            socket =
              socket
              |> assign(:authenticated, false)

            if unquote(msg) do
              send(self(), unquote(msg))
            end

            {:noreply, socket}
        end
      end
    end
  end

  def user_from_session(key, backend) do
    case Pow.Store.CredentialsCache.get([backend: backend], key) do
      {user, _} -> {:ok, user}
      _ -> :not_found
    end
  end
end
