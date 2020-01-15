defmodule Web.LayoutView do
  use Web, :view

  def get_active_locale_class(locale) do
    if Gettext.get_locale(Web.Gettext) == locale, do: "active"
  end
  def svelte(name, props, class \\ "") do
    :div
    |> tag([data: [props: json(props)], id: generate_id(name), class: class])
  end

  def json(props) when is_map(props) do
    props
    |> Jason.encode
    |> case do
      {:ok, message} -> message
      {:error, _} -> ""
    end
  end
  def json(props), do: props

  def generate_id(name) do
    "svelte-#{String.replace(name, " ", "-")}-root"
  end
end
