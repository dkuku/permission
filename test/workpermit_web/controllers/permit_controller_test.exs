defmodule WorkpermitWeb.PermitControllerTest do
  use WorkpermitWeb.ConnCase

  alias Workpermit.Permits
  import Workpermit.Factory

  @create_attrs %{
    category: 42,
    closed: ~N[2010-04-17 14:00:00],
    controller: build(:user),
    finish: ~N[2010-04-17 14:00:00],
    issued: ~N[2010-04-17 14:00:00],
    issuer: build(:user),
    number: 42,
    performer: build(:user),
    start: ~N[2010-04-17 14:00:00]
  }
  @invalid_attrs %{
    category: nil,
    closed: nil,
    controller: nil,
    finish: nil,
    issued: nil,
    issuer: nil,
    number: nil,
    performer: nil,
    protective_equipment: nil,
    start: nil
  }

  def fixture(:permit) do
    {:ok, permit} = Permits.create_permit(@create_attrs)
    permit
  end

  describe "index" do
    test "lists all permits", %{conn: conn} do
      conn = get(conn, Routes.permit_path(conn, :index))
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
