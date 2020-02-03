defmodule Web.LivePermitView do
  use Phoenix.LiveView
  use Phoenix.HTML
  import Web.Gettext
  alias Web.Router.Helpers, as: Routes
  alias Workpermit.Permits
  use Web.LiveViewUserHelper, otp_app: :workpermit

  def render(assigns) do
    Phoenix.View.render(Web.PermitView, "live_form.html", assigns)
  end

  def mount(session, socket) do
    %{current_user: user} = current_user(socket, session).assigns
    socket =
      socket
      |> current_user(session)
      |> IO.inspect()
      |> assign(:current_step, 1)
      |> assign(:action, 1)
      |> assign(:changeset, Permits.change_permit())
      |> assign(:pe, Permits.pe_fields())
      |> assign(:categories, Permits.category_fields())
      # use choosen category from settings
      |> assign(:choosen_category, Permits.choosen_category(:general))
      |> assign(:current_user, full_name(user))
      |> current_user(session)
      |> IO.inspect()
    {:ok, socket}
  end

  def handle_event("prev-step", _value, socket) do
    new_step = max(socket.assigns.current_step - 1, 1)
    IO.inspect(new_step)
    {:noreply, assign(socket, :current_step, new_step)}
  end

  def handle_event("next-step", _value, socket) do
    current_step = socket.assigns.current_step
    changeset = socket.assigns.changeset

    IO.inspect(changeset.errors)
    step_invalid =
      case current_step do
        1 -> Enum.any?(Keyword.keys(changeset.errors), fn k -> k in [:category] end)
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

  def full_name(%{first_name: f, last_name: l}), do: "#{f} #{l}"
  def full_name(_), do: gettext("No data")
end

