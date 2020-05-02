defmodule Web.LivePermitView do
  import Phoenix.LiveView.Helpers
  use Phoenix.LiveView
  use Phoenix.HTML
  import Web.Gettext
  alias Web.Router.Helpers, as: Routes
  alias Workpermit.Permits
  use Web.LiveViewUserHelper, otp_app: :workpermit

  def render(assigns) do
    Phoenix.View.render(Web.PermitView, "live_form.html", assigns)
  end

  def mount(_params, session, socket) do
    %{current_user: user} = current_user(socket, session).assigns

    socket =
      socket
      |> current_user(session)
      |> assign(:current_step, 1)
      |> assign(:action, 1)
      |> assign(:changeset, Permits.change_permit())
      |> assign(:pe, Permits.pe_fields())
      |> assign(:categories, Permits.category_fields())
      # use choosen category from settings
      |> assign(:choosen_category, Permits.choosen_category(:general))
      |> assign(:current_user, full_name(user))
      |> assign(:usernames, [])
      |> current_user(session)

    {:ok, socket, temporary_assigns: [usernames: []]}
  end

  def handle_event("suggest-username", payload, socket) do
    IO.inspect(payload)
    usernames = search_usernames(payload["value"])
    {:noreply, assign(socket, :usernames, usernames)}
  end

  def handle_event("prev-step", _value, socket) do
    new_step = max(socket.assigns.current_step - 1, 1)
    {:noreply, assign(socket, :current_step, new_step)}
  end

  def handle_event("next-step", _value, socket) do
    current_step = socket.assigns.current_step
    changeset = socket.assigns.changeset

    step_invalid =
      case current_step do
        1 -> Enum.any?(Keyword.keys(changeset.errors), fn k -> k in [:categor] end)
        2 -> Enum.any?(Keyword.keys(changeset.errors), fn k -> k in [:type] end)
        3 -> Enum.any?(Keyword.keys(changeset.errors), fn k -> k in [:start_time] end)
        4 -> Enum.any?(Keyword.keys(changeset.errors), fn k -> k in [:type] end)
        5 -> Enum.any?(Keyword.keys(changeset.errors), fn k -> k in [:type] end)
        _ -> true
      end

    new_step = if step_invalid, do: current_step, else: current_step + 1
    {:noreply, assign(socket, :current_step, new_step)}
  end

  def handle_event("validate", %{"permit" => params}, socket) do
    changeset = Permits.change_permit(params) |> Map.put(:action, :insert)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"permit" => params}, socket) do
    user = socket.assigns.current_user
    changeset = Permits.change_permit(params)
    {:ok, permit} = Permits.create_permit(user, params)

    case changeset.valid? do
      true ->
        {:stop,
         socket
         |> put_flash(:info, "Permit inserted => #{inspect(permit.id)}")
         |> redirect(to: Routes.permit_path(Web.Endpoint, :index))}

      false ->
        {:noreply, assign(socket, :changeset, %{changeset | action: :insert})}
    end
  end

  def handle_info(:pow_auth_ttl, socket), do: {:noreply, socket}

  def full_name(%{first_name: f, last_name: l}), do: "#{f} #{l}"
  def full_name(_), do: gettext("No data")
  def search_usernames(""), do: []
  def search_usernames(name), do: Workpermit.Users.find_names(name)

  def error_tag(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      content_tag(:span, error,
        class: "help-block",
        data: [phx_error_for: input_id(form, field)]
      )
    end)
  end
end
