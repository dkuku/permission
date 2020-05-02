defmodule Web.TenantHelper do
  @default_tenant "demo"
  def callback(conn, tenant_from_url) do
    tenant =
      case Triplex.exists?(tenant_from_url) do
        true -> tenant_from_url
        _ -> @default_tenant
      end

    conn
    |> Plug.Conn.assign(:current_tenant, tenant)
  end

  def failure_callback(conn, tenant) do
    IO.inspect("current_tenant in failure: #{tenant}")

    Plug.Conn.assign(conn, :current_tenant, @default_tenant)
  end

  def tenant_handler(nil) do
    IO.inspect("current_tenant: nil")
    nil
  end

  def tenant_handler(tenant) do
    IO.inspect("current_tenant: #{tenant}")
    tenant
  end
end
