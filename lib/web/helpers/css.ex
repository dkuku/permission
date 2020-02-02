defmodule Web.CSS do
  def nav_text_color(conn) do
    case get_layout(conn) do
      "landing.html" -> "text-white"
      _ -> "text-gray-darker"
    end
  end

  defp get_layout(conn) do
    {Web.LayoutView, layout} = conn.assigns.layout
    layout
  end
end
