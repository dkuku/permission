defmodule Web.UserControllerTest do
  #  use Web.ConnCase
  #
  #  alias Workpermit.Users
  #
  #  @create_attrs %{
  #    email: "some@email.co",
  #    password: "some password_hash",
  #    password_confirmation: "some password_hash",
  #    first_name: "some first_name",
  #    last_name: "some last_name",
  #    phone: "some phone"
  #  }
  #  @update_attrs %{
  #    email: "some@email.co",
  #    password: "password_hash",
  #    password_confirmation: "password_hash",
  #    first_name: "some updated first_name",
  #    last_name: "some updated last_name",
  #    phone: "some updated phone"
  #  }
  #  @invalid_attrs %{email: nil, password: nil, first_name: nil, last_name: nil, phone: nil}
  #
  #  describe "new user" do
  #    test "renders form", %{conn: conn} do
  #      conn = get(conn, Routes.user_path(conn, :new))
  #      assert html_response(conn, 200) =~ "Sign Up"
  #    end
  #  end
  #
  #  describe "create user" do
  #    test "redirects to show when data is valid", %{conn: conn} do
  #      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
  #
  #      assert redirected_to(conn) == Routes.permit_path(conn, :index)
  #      assert html_response(conn, 302) =~ "permits"
  #    end
  #
  #    test "renders errors when data is invalid", %{conn: conn} do
  #      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
  #      assert html_response(conn, 200) =~ "Sign Up"
  #    end
  #  end
  #
  #  describe "edit user" do
  #    setup [:create_user]
  #
  #    test "renders form for editing chosen user", %{conn: conn, user: user} do
  #      conn = get(conn, Routes.user_path(conn, :edit, user))
  #      assert html_response(conn, 200) =~ "Edit User"
  #    end
  #  end
  #
  #  describe "update user" do
  #    setup [:create_user]
  #
  #    test "redirects when data is valid", %{conn: conn, user: user} do
  #      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
  #      assert redirected_to(conn) == Routes.user_path(conn, :show, user)
  #
  #      conn = get(conn, Routes.user_path(conn, :show, user))
  #      assert html_response(conn, 200) =~ "some updated email"
  #    end
  #
  #    test "renders errors when data is invalid", %{conn: conn, user: user} do
  #      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
  #      assert html_response(conn, 200) =~ "Edit User"
  #    end
  #  end
  #
  #  describe "index" do
  #    test "lists all users", %{conn: conn} do
  #      conn = get(conn, Routes.user_path(conn, :index))
  #      assert html_response(conn, 200) =~ "User Profiles"
  #    end
  #  end
  #
  #  describe "delete user" do
  #    setup [:create_user]
  #
  #    test "deletes chosen user", %{conn: conn, user: user} do
  #      conn = delete(conn, Routes.user_path(conn, :delete, user))
  #      assert redirected_to(conn) == Routes.user_path(conn, :index)
  #
  #      assert_error_sent 404, fn ->
  #        get(conn, Routes.user_path(conn, :show, user))
  #      end
  #    end
  #  end
  #
  #  def fixture(:user) do
  #    {:ok, user} = Users.create_user(@create_attrs)
  #    user
  #  end
  #
  #  defp create_user(_) do
  #    user = fixture(:user)
  #    {:ok, user: user}
  #  end
end
