defmodule Web.PermitControllerTest do
  use Web.ConnCase

  alias Workpermit.Permits
  alias Workpermit.Accounts.User
  alias Workpermit.Repo
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

  setup %{conn: conn} do
    user =  User.build_user(@valid_user)
            |> Repo.insert!
    conn_with_user = assign(conn, :user, user)
    IO.inspect(conn_with_user)
    {:ok, %{conn: conn_with_user}}
  end

  describe "index" do
    test "lists all permits", %{conn: conn} do
      conn = get(conn, Routes.permit_path(conn, :index))
      IO.inspect(conn)
      assert html_response(conn, 200) =~ "Permits List"
    end
  end

  describe "new permit" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.permit_path(conn, :new))
      assert html_response(conn, 200) =~ "Create permit"
    end
  end

  describe "create permit" do
    #TODO - add nested form for protective equipment
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.permit_path(conn, :create), permit: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.permit_path(conn, :show, id)

      conn = get(conn, Routes.permit_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Permit"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.permit_path(conn, :create), permit: @invalid_attrs)
      assert html_response(conn, 200) =~ "Create permit"
    end
  end

  defp create_permit(_) do
    permit = fixture(:permit)
    {:ok, permit: permit}
  end
end
