defmodule Web.PermitControllerTest do
  use Web.ConnCase

  alias Workpermit.Permits

  @create_attrs %{
    "category" => "electrical",
    "closed_time" => ~N[2020-04-17 14:00:00],
    "controller_name" => "Controller Name",
    "finish_time" => ~N[2020-04-17 14:00:00],
    "issuer_name" => "Issuer Name",
    "number" => 42,
    "performer_name" => "Performer Name",
    "protective_equipment" => [],
    "start_time" => ~N[2020-04-17 14:00:00]
  }
  @invalid_attrs %{
    "category" => nil,
    "closed_time" => nil,
    "controller_name" => nil,
    "finish_time" => nil,
    "issuer" => nil,
    "issuer_name" => nil,
    "number" => nil,
    "performer_name" => nil,
    "protective_equipment" => nil,
    "start_time" => nil
  }

  @valid_user %{
    first_name: "John",
    last_name: "Smith",
    email: "john@example.com",
    password: "secret12",
    password_confirmation: "secret12",
    phone: "1111"
  }

  describe "unauthenticated user" do
    test "index redirects to login form", %{conn: conn} do
      conn = get(conn, Routes.permit_path(conn, :index))
      assert html_response(conn, 302) =~ "redirected"
    end

    test "show permit redirects to login form", %{conn: conn} do
      conn = get(conn, Routes.permit_path(conn, :show, 1))
      assert html_response(conn, 302) =~ "redirected"
    end

    test "new permit redirects to login form", %{conn: conn} do
      conn = get(conn, Routes.permit_path(conn, :new))
      assert html_response(conn, 302) =~ "redirected"
    end
  end

  describe "authenticated user" do
    setup %{conn: conn} do
      {:ok, user} = Workpermit.Users.create_user(@valid_user)
      authed_conn = Pow.Plug.assign_current_user(conn, user, [])

      {:ok, conn: authed_conn, user: user}
    end

    test "lists all permits", %{conn: conn, user: _user} do
      conn = get(conn, Routes.permit_path(conn, :index))
      assert html_response(conn, 200) =~ "Permits List"
    end

    test "new permit renders form", %{conn: conn} do
      conn = get(conn, Routes.permit_path(conn, :new))
      assert html_response(conn, 200) =~ "Create permit"
    end

    # TODO - add nested form for protective equipment
    test "create permit redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.permit_path(conn, :create), permit: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.permit_path(conn, :show, id)
    end

    test "show permit page when exists", %{conn: conn, user: user} do
      {:ok, permit} = create_permit(user)
      conn = get(conn, Routes.permit_path(conn, :show, permit.id))
      assert html_response(conn, 200) =~ "Permit"
      assert html_response(conn, 200) =~ "Category:"
    end

    test " create permit renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.permit_path(conn, :create), permit: @invalid_attrs)
      assert html_response(conn, 200) =~ "Create permit"
    end
  end

  defp create_permit(user) do
    Permits.create_permit(user, @create_attrs)
  end
end
