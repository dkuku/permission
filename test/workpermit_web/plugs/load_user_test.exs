defmodule WorkpermitWeb.Plugs.LoadUserTest do
  use WorkpermitWeb.ConnCase
  alias Workpermit.Accounts

  @valid_attrs %{
    "first_name" => "John",
    "last_name" => "Smith",
    "email" => "john@example.com",
    "password" => "secret",
    "phone" => "1111"
  }

  test "fetch customer from session on subsequent visit" do
    # Create a new customer
    {:ok, user} = Accounts.create_user(@valid_attrs)

    # Build a new conn by posting login data to "/sign-in" path
    conn = post build_conn(), "/sign-in", %{"session" => @valid_attrs}

    # We reuse the same conn now instead of building a new one
    conn = get(conn, "/")

    # now we expect the conn to have the `:current_customer` data loaded in conn.
    assert user.id == conn.assigns.user.id
  end
end
