# lib/web/live/precautions_input_component.ex
defmodule Web.PrecautionsInputComponent do
  use Phoenix.LiveView
  use Phoenix.HTML
  import Web.Gettext
  import Web.PermitView, only: [gettext_category: 1]

  def mount(_, session, socket) do
    socket =
      socket
      |> assign(precautions: session["precautions"])
      |> assign(f: session["f"])

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <div>
        <%= label @f, :precautions, class: "block mb-6" do %>
          <div class="flex justify-between">
              <span class="block form-label c-h5"><%= gettext("Precautions") %></span>
              <button type="button"
                phx-click="add-input" 
                class="px-2 py-1 bg-transparent border rounded cursor-pointer text-small text-gray-darker border-gray-dark "
                >
                  Add field
              </button>
          </div>
        <% end %>
        <%= for {prec, i} <- Enum.with_index(@precautions) do %>
          <%= precautions_input(prec, i) %>
        <% end %>
      </div>
    """
  end

  def precautions_input(text, i) do
    ~E"""
    <div class="flex justify-between">
      <input  type="text" 
        phx-keyup="changed-input"
        name="permit[precautions][]"
        value="<%= text %>"
        phx-value-index="<%= i %>"
        class="w-full my-1 mb-2 form-input"
        >
      <button type="button" 
        phx-click="remove-input" 
        phx-value-index="<%= i %>"
        class="w-8 h-8 px-2 py-2 m-2 bg-transparent border rounded cursor-pointer text-small"
      >
        x
      </button>
    </div>
    """
  end

  def handle_event("changed-input", payload, socket) do
    index = get_index(payload)
    updated_precautions = List.replace_at(socket.assigns.precautions, index, payload["value"])
    {:noreply, assign(socket, :precautions, updated_precautions)}
  end

  def handle_event("add-input", _payload, socket) do
    updated_precautions = socket.assigns.precautions ++ [""]
    {:noreply, assign(socket, :precautions, updated_precautions)}
  end

  def handle_event("remove-input", payload, socket) do
    index = get_index(payload)
    updated_precautions = List.delete_at(socket.assigns.precautions, index)
    {:noreply, assign(socket, :precautions, updated_precautions)}
  end

  defp get_index(payload) do
    payload["index"]
    |> String.to_integer()
  end
end
