defmodule Web.PermitControllerTest do
  use Web.ConnCase

  alias Workpermit.Permits
  alias Workpermit.Users
  import Workpermit.Factory

  @create_attrs %{
    category: 42,
    closed_time: ~N[2020-04-17 14:00:00],
    controller_name: "Controller Name",
    finish_time: ~N[2020-04-17 14:00:00],
    issuer: build(:user),
    issuer_name: "Issuer Name",
    number: 42,
    performer_name: "Performer Name",
    protective_equipment: [],
    start: ~N[2020-04-17 14:00:00]
  }
  @invalid_attrs %{
    category: nil,
    closed_time: nil,
    controller_name: nil,
    finish_time: nil,
    issuer: nil,
    issuer_name: nil,
    number: nil,
    performer_name: nil,
    protective_equipment: nil,
    start_time: nil
  }

  @valid_user %{
    "first_name" => "John",
    "last_name" => "Smith",
    "email" => "john@example.com",
    "password" => "secret",
    "phone" => "1111"
  }

  def fixture(:permit) do
    {:ok, permit} = Permits.create_permit(@create_attrs)
    permit
  end

  @session Plug.Session.init(
    store: :cookie,
    key: "_app",
    encryption_salt: "yadayada",
    signing_salt: "yadayada"
  )

  setup do
    {:ok, user} = Users.create_user(@valid_user)
    conn =
      Plug.Test.conn(:get, "/")
      |> Map.put(:secret_key_base, String.duplicate("abcdefgh", 8))
      |> Plug.Session.call(@session)
      |> Plug.Conn.fetch_session()
      |> assign(:user, user)
      |> put_session(:user_id, user.id)
      |> configure_session(renew: true)
    [conn: conn, user: user]
  end

  describe "index" do
    # test "lists all permits", context do
    #  IO.inspect(context)
    test "lists all permits", %{conn: conn, user: user} do
    IO.inspect(conn.private)
    IO.inspect(conn.assigns)
      conn = get(conn, Routes.permit_path(conn, :index))
      assert get_session(conn, :user_id) == user.id
      assert html_response(conn, 200) =~ "Permits List"
    end
  end

  describe "new permit" do
    test "renders form", %{conn: conn} do
    IO.inspect(conn.private)
    IO.inspect(conn.assigns)
      conn = get(conn, Routes.permit_path(conn, :new))
      assert html_response(conn, 200) =~ "Create permit"
    end
  end

  describe "create permit" do
    #TODO - add nested form for protective equipment
    test "redirects to show when data is valid", %{conn: conn} do
    IO.inspect(conn.private)
    IO.inspect(conn.assigns)
      conn = post(conn, Routes.permit_path(conn, :create), permit: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.permit_path(conn, :show, id)

      conn = get(conn, Routes.permit_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Permit"
    end

    test "renders errors when data is invalid", %{conn: conn} do
    IO.inspect(conn.private)
      conn = post(conn, Routes.permit_path(conn, :create), permit: @invalid_attrs)
      assert html_response(conn, 200) =~ "Create permit"
    end
  end

  defp create_permit(_) do
    permit = fixture(:permit)
    {:ok, permit: permit}
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
