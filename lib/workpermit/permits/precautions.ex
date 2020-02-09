defmodule Permits.Precautions do
  use Ecto.Type
  def type, do: :string

  @spec cast(list(String.t())) :: {:ok, String.t()}
  def cast(value) when is_list(value) do
    {:ok, "□ " <> Enum.join(value, "  \n□ ")}
  end
  def load(value), do: {:ok, value}
  def dump(value), do: {:ok, value}
end
