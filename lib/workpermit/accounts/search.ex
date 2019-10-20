defmodule Workpermit.Accounts.Search do
  @moduledoc """
  Implementation of the full-text user search
  """

  import Ecto.Query

  @spec run(Ecto.Query.t(), any()) :: Ecto.Query.t()
  def run(query, search_name) do
   where(
      query,
      fragment(
        "to_tsvector('english', first_name || ' ' || coalesce(last_name, ' ')) @@
        to_tsquery(?)",
        ^prefix_search(search_name)
      )
    )
  end
  defp prefix_search(term), do: String.replace(term, ~r/\W/u, "") <> ":*"
end
