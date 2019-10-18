defmodule WorkpermitWeb.Markdown do
  @moduledoc """
  Render a string as markdown in the FirestormWeb style.
  Then sanitize the resulting HTML (eventually...FIXME).
  """
  def render(body) do
    if body do
      Earmark.as_html!(body)
    else
      "Nothing"
    end
  end
end
