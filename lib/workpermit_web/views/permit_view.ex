defmodule WorkpermitWeb.PermitView do
  use WorkpermitWeb, :view
  alias WorkpermitWeb.Markdown
  alias Workpermit.IsoSymbols
  require EEx

  def markdown(body) do
    body
    |> Markdown.render
    |> raw
  end
  def iso_image(img), do: img |> IsoSymbols.symbol_to_image_path
  def iso_meaning(img), do: img |> IsoSymbols.symbol_to_sign_meaning

  def date_time(%{} = date), do: date |> Timex.format!("%Y/%m/%d %H:%M", :strftime)
  def date_time(_), do: gettext("No data")
  def time(%{} = date), do: date |> Timex.format!("%H:%M", :strftime)
  def time(_), do: gettext("No data")
  def date(%{} = date), do: date |> Timex.format!("%Y/%m/%d", :strftime)
  def date(_), do: gettext("No data")
  def full_name(%{first_name: f, last_name: l}), do: "#{f} #{l}"
  def full_name(_), do: gettext("No data")

  def permit_datetime_select(form, field, opts \\ []) do
    builder = fn b ->
      now = Timex.now

      class = "form-input mt-1"

      [~E"<div>",
        gettext("Year"),
        b.(:year, [options: year_select(now), value: now.year, class: class]),
        ~E" </div><div>",
        gettext("Month"),
        b.(:month, [options: month_select(now), value: now.month, class: class]),
        ~E" </div><div>",
        gettext("Day"),
        b.(:day, [options: day_select(now), value: now.day, class: class]),
        ~E" </div><div>",
        gettext("Hour"),
        b.(:hour, [options: hour_select(now), class: class]),
        ~E" </div><div>",
        gettext("Minutes"),
        b.(:minute, [options: minute_select(), class: class]),
        ~E"</div>"
      ]
    end
    datetime_select(form, field, [builder: builder] ++ opts)
  end

  defp year_select(%{year: y, month: 1, day: 1}), do: [y, y - 1]
  defp year_select(%{year: y, month: 12, day: d}) when d in 28..31, do: [y, y + 1]
  defp year_select(%{year: y}), do: [y]

  defp month_select(%{month: 1, day: 1}), do: [1, 12] 
  defp month_select(%{month: m, day: 1}), do: [m, m - 1] 
  defp month_select(%{month: 12, day: d}) when d in 27..31, do: [12, 1] 
  defp month_select(%{month: m, day: d}) when d in 27..31, do: [m, m + 1] 
  defp month_select(%{month: m}), do: [m] 

  defp day_select(now) do
    [
        now.day,
        Timex.shift(now, days:  1).day,
        Timex.shift(now, days:  2).day,
        Timex.shift(now, days:  3).day,
        Timex.shift(now, days:  4).day,
        Timex.shift(now, days: -1).day,
      ]
  end

  defp hour_select(now), do: Enum.to_list(now.hour..23) ++ Enum.to_list(1..now.hour)
  defp minute_select(), do: ["00","15","30","45"] 
end
