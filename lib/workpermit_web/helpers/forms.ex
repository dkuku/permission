defmodule WorkpermitWeb.Helpers.Forms do
  import Phoenix.HTML.Form, only: [datetime_select: 3]
  import Phoenix.HTML, only: [sigil_E: 2]
  require EEx
  
  def permit_datetime_select(form, field, opts \\ []) do
    builder = fn b ->
      today = Timex.now

      year = [today.year]
      year = if today.month == 1 and today.day == 1, do: [today.year - 1, today.year], else: year
      year = if today.month == 12 and today.day > Timex.shift(today, days: +4).day, do: [today.year, today.year + 1], else: year

      month = [today.month]
      month = if today.day == 1, do: [Timex.shift(today, months: -1).month, today.month], else: month
      month = if today.day > Timex.shift(today, days: 4).day, do: [today.month, Timex.shift(today, months: 1).month], else: month

      day = [
        today.day,
        Timex.shift(today, days: +1).day,
        Timex.shift(today, days: +2).day,
        Timex.shift(today, days: +3).day,
        Timex.shift(today, days: +4).day,
        Timex.shift(today, days: -1).day,
      ]
      class = "form-input mt-1"

      [~E"<div>Year: ",
        b.(:year, [options: year, value: today.year, class: class]),
        ~E" </div><div> Month: ", 
        b.(:month, [options: month, value: today.month, class: class]),
        ~E" </div><div> Day: ", 
        b.(:day, [options: day, value: today.day, class: class]),
        ~E" </div><div> Hour: ", 
        b.(:hour, [options: Enum.to_list(today.hour..23) ++ Enum.to_list(1..today.hour), class: class]),
        ~E" </div><div> Minute: ", 
        b.(:minute, [options: ["00","15","30","45"], class: class]),
        ~E"</div>"
      ]
    end

    datetime_select(form, field, [builder: builder] ++ opts)
  end

  def get_day() do
    Timex.format!(Timex.now(), "%d")
  end
end


