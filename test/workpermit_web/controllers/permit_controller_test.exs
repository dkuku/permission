defmodule WorkpermitWeb.PermitControllerTest do
  use WorkpermitWeb.ConnCase

  alias Workpermit.Permits

  @create_attrs %{
    category: 42,
    closed: ~N[2010-04-17 14:00:00],
    controller_id: "some controller_id",
    finish: ~N[2010-04-17 14:00:00],
    issued: ~N[2010-04-17 14:00:00],
    issuer_id: "some issuer_id",
    number: 42,
    performer_id: "some performer_id",
    start: ~N[2010-04-17 14:00:00]
  }
  @invalid_attrs %{
    category: nil,
    closed: nil,
    controller_id: nil,
    finish: nil,
    issued: nil,
    issuer_id: nil,
    number: nil,
    performer_id: nil,
    protective_equipment_value: nil,
    start: nil
  }

  def fixture(:permit) do
    {:ok, permit} = Permits.create_permit(@create_attrs)
    permit
  end

  describe "index" do
    test "lists all permits", %{conn: conn} do
      conn = get(conn, Routes.permit_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Permits"
    end
  end

  describe "new permit" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.permit_path(conn, :new))
      assert html_response(conn, 200) =~ "New Permit"
    end
  end

  describe "create permit" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.permit_path(conn, :create), permit: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.permit_path(conn, :show, id)

      conn = get(conn, Routes.permit_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Permit"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.permit_path(conn, :create), permit: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Permit"
    end
  end

  defp create_permit(_) do
    permit = fixture(:permit)
    {:ok, permit: permit}
  end
end
