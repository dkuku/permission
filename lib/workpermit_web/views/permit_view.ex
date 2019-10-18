defmodule WorkpermitWeb.PermitView do
  use WorkpermitWeb, :view
  alias WorkpermitWeb.Markdown

  def markdown(body) do
    body
    |> Markdown.render
    |> raw
  end
end
