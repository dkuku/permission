
defmodule Web.RacerView do
  use Phoenix.LiveView
  use Phoenix.HTML
  def original_text do
"Say your prayers little one
Don't forget, my son
To include everyone
Tuck you in, warm within
Keep you free from sin
Till the sandman he comes
Sleep with one eye open
Gripping your pillow tight"
  end

  def html_text(multi_line_string) do
    multi_line_string |> String.replace("\n", "<br>") |> String.replace("\n", "")
  end
  def render(assigns) do
    ~L"""
    <div class="">
      <%= {:safe, html_text(original_text())} %>
      <div>
          <%= @deploy_step %>
      </div>
      <form phx-change="validate" phx-submit="save">
        <textarea phx-keyup="keypress" type="text" name="text"></textarea>
        <input type="text" name="user[phone_number]" id="user-phone-number" phx-hook="PhoneNumber" />
      </form>
		</div>
    """
  end

  def mount(_session, socket) do
    {:ok, assign(socket, deploy_step: "Ready!")}
  end
  def handle_event("validate", %{"text" => text} = value, socket) do
    len = String.length(text)
    String.slice(original_text(), 0, len)
    |> String.myers_difference(text)
    |> IO.inspect()
    {:noreply, assign(socket, deploy_step: text)}
  end
  def handle_event("save", value, socket) do
    IO.inspect(value)
    {:noreply, assign(socket, deploy_step: value)}
  end
  def handle_event("keypress", %{"key" => key}, socket) do
    {:noreply, socket}
  end

  def svelte(name, props) do
    :div
    |> tag([data: [props: json(props)], id: generate_id(name), "phx-update": :ignore])
  end

  def json(props) do
    props
    |> Jason.encode
    |> case do
      {:ok, message} -> message
      {:error, _} -> ""
    end
  end

  def generate_id(name) do
    "svelte-#{String.replace(name, " ", "-")}-root"
  end
end

