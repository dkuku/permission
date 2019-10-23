defmodule WorkpermitWeb.Markdown do
  @moduledoc """
  """
  def render(body) do
    if body do
      Earmark.as_html!(body)
    else
      "Nothing"
    end
  end
end
