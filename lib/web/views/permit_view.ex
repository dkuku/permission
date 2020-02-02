defmodule Web.PermitView do
  use Web, :view
  alias Web.Markdown
  alias Workpermit.IsoSymbols
  alias Workpermit.Permits
  require EEx

  def markdown(body) do
    body
    |> Markdown.render()
    |> raw
  end

  def category_query(params, category) do
    search_query = %{
      "q" => %{"category_eq" => category},
      "s" => "number+desc"
    }
    Map.merge(params, search_query)
  end
  def link_sorted(conn, show, params, new_params, class  \\ "") do
    updated_params = Map.merge(params, new_params)
    route = Routes.permit_path(conn, :index, updated_params)
    link show, to: route, class: class
  end
  def iso_image_category(category), do:  category |> Permits.image() |> iso_image()
  def iso_image(img), do: img |> IsoSymbols.to_image_path()
  def iso_meaning(img), do: img |> IsoSymbols.to_sign_meaning()

  def checkbox(string) when is_bitstring(string), do: "□" <> " " <> string
  def checkbox(nil), do: "□"
  def line_break(string), do: string <> "  
"

  def prec,
    do:
      Permits.default_precautions()
      |> Enum.map(fn x -> x |> checkbox |> line_break end)
      |> Enum.join()

  def date_time(%{} = date), do: date |> Timex.format!("%m/%d %H:%M", :strftime)
  def date_time(_), do: gettext("No data")
  def time(%{} = date), do: date |> Timex.format!("%H:%M", :strftime)
  def time(_), do: gettext("No data")
  def date(%{} = date), do: date |> Timex.format!("%Y/%m/%d", :strftime)
  def date(_), do: gettext("No data")
  def full_name(%{first_name: f, last_name: l}), do: "#{f} #{l}"
  def full_name(_), do: gettext("No data")

  def permit_datetime_select(form, field, opts \\ []) do
    builder = fn b ->
      render("date_select.html", b: b)
    end

    datetime_select(form, field, [builder: builder] ++ opts)
  end

  defp year_select(%{year: y, month: 1, day: 1}), do: [y, y - 1]
  defp year_select(%{year: y, month: 12, day: d}) when d in 27..31, do: [y, y + 1]
  defp year_select(%{year: y}), do: [y]

  defp month_select(%{month: 1, day: 1}), do: [1, 12]
  defp month_select(%{month: m, day: 1}), do: [m, m - 1]
  defp month_select(%{month: 12, day: d}) when d in 27..31, do: [12, 1]
  defp month_select(%{month: m, day: d}) when d in 27..31, do: [m, m + 1]
  defp month_select(%{month: m}), do: [m]

  defp day_select(now) do
    [
      now.day,
      Timex.shift(now, days: 1).day,
      Timex.shift(now, days: 2).day,
      Timex.shift(now, days: 3).day,
      Timex.shift(now, days: 4).day,
      Timex.shift(now, days: 5).day,
      Timex.shift(now, days: -1).day
    ]
  end

  defp hour_select(now), do: Enum.to_list(now.hour..23) ++ Enum.to_list(1..now.hour)
  defp minute_select(), do: ["00", "15", "30", "45"]

  def render("permits.new.html", _assigns) do
    ~E(<script src="/js/multi_step_form.js"></script>)
  end
end
