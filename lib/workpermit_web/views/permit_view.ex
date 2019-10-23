defmodule WorkpermitWeb.PermitView do
  use WorkpermitWeb, :view
  alias WorkpermitWeb.Markdown
  require EEx

  def markdown(body) do
    body
    |> Markdown.render
    |> raw
  end

  def permit_datetime_select(form, field, opts \\ []) do
    builder = fn b ->
      now = Timex.now

      class = "form-input mt-1"

      [~E"<div>Year: ",
        b.(:year, [options: year_select(now), value: now.year, class: class]),
        ~E" </div><div> Month: ", 
        b.(:month, [options: month_select(now), value: now.month, class: class]),
        ~E" </div><div> Day: ", 
        b.(:day, [options: day_select(now), value: now.day, class: class]),
        ~E" </div><div> Hour: ", 
        b.(:hour, [options: hour_select(now), class: class]),
        ~E" </div><div> Minute: ", 
        b.(:minute, [options: minute_select(), class: class]),
        ~E"</div>"
      ]
    end
    datetime_select(form, field, [builder: builder] ++ opts)
  end

  defp year_select(now) do
    year = [now.year]
    year = if now.month == 1 and now.day == 1, do: [now.year, now.year - 1], else: year
    year = if now.month == 12 and now.day > Timex.shift(now, days: +4).day, do: [now.year, now.year + 1], else: year
    year
  end

  defp month_select(now) do
    month = [now.month]
    month = if now.day == 1, do: [Timex.shift(now, months: -1).month, now.month], else: month
    month = if now.day > Timex.shift(now, days: 4).day, do: [now.month, Timex.shift(now, months: 1).month], else: month
    month
  end

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
