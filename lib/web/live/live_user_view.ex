defmodule Web.UserInputComponent do
  use Phoenix.LiveView
  use Phoenix.HTML
  import Web.PermitView, only: [gettext_category: 1]

  def mount(_, session, socket) do
    socket =
      socket
      |> assign(actor: session["actor"])
      |> assign(usernames: session["usernames"])
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <div>
        <label for="permit_<%= @actor %>" class="block mt-4 mb-2 c-h6" >
            <span class="block mt-1 form-label c-h5"><%= gettext_category(@actor) %></span>
        </label>
          <input  phx-keyup="suggest-username"
                  type="text"
                  name="permit[<%= @actor %>]"
                  id="permit_<%= @actor %>"
                  list="<%= @actor %>_list"
                  placeholder="Search..."
                  class="w-full my-1 mb-2 form-input">
          <datalist id="<%= @actor %>_list" class="">
            <%= for match <- @usernames do %>
              <option class="" value="<%= match %>"><%= match %></option>
            <% end %>
          </datalist>
      </div>
    """
  end
  def search_usernames(""), do: []
  def search_usernames(name), do: Workpermit.Users.find_names(name)
  def handle_event("suggest-username", payload, socket) do
    usernames = search_usernames(payload["value"])
    {:noreply, assign(socket, :usernames, usernames)}
  end
end
