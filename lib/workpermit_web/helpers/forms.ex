defmodule WorkpermitWeb.Helpers.Forms do
  import Phoenix.HTML.Form, only: [datetime_select: 3]
  import Phoenix.HTML, only: [sigil_E: 2]
  require EEx
  
  def permit_datetime_select(form, field, opts \\ []) do
    builder = fn b ->
      ~E"""
      Date: <%= b.(:day, options: [{1,1},{2,2}]) %> Month: <%= b.(:month, []) %> Year: <%= b.(:year, []) %>
      Hour: <%= b.(:hour, []) %> Minute: <%= b.(:minute, []) %>
      """
    end

    datetime_select(form, field, [builder: builder] ++ opts)
  end

  def get_day() do
    Timex.format!(Timex.now(), "%d")
  end
end


