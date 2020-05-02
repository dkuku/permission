defmodule Web.PowTriplexSessionPlug do
  @default_tenant "demo"

  def init(config), do: config

  def call(conn, config) do
    IO.inspect(conn.assigns)
    tenant = conn.assigns[:current_tenant] || conn.assigns[:raw_current_tenant]

    prefixed =
      case Triplex.exists?(tenant) do
        true -> Triplex.to_prefix(tenant)
        _ -> Triplex.to_prefix(@default_tenant)
      end

    config = Keyword.put(config, :repo_opts, prefix: prefixed)

    Pow.Plug.Session.call(conn, config)
  end
end
