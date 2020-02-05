defmodule Web.UserInputComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

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
  def gettext_category(_), do: "rarar"
end
