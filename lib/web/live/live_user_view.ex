defmodule Web.UserInputComponent do
  use Phoenix.LiveView
  use Phoenix.HTML

  def mount(sa, session, socket) do
    socket =
      socket
      |> assign(actor: session["actor"])
      |> assign(usernames: session["usernames"])
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <div>
          <span class="block form-label"><%= gettext_category(@actor) %></span>
          <input  phx-keyup="suggest-username" type="text" name="permit[<%= @actor %>]" id="permit_<%= @actor %>" list="<%= @actor %>__list" placeholder="Search..." class="w-full mt-1 form-input">
          <datalist phx-update="append" id="<%= @actor %>__list">
            <%= for match <- @usernames do %>
              <option value="<%= match %>"><%= match %></option>
            <% end %>
          </datalist>
      </div>
    """
  end
  def search_usernames(""), do: []
  def search_usernames(name), do: Workpermit.Users.find_names(name)
  def handle_event("suggest-username", payload, socket) do
    IO.inspect(payload)
    usernames = search_usernames(payload["value"])
    {:noreply, assign(socket, :usernames, usernames)}
  end
  def gettext_category(_), do: "rarar"
end
