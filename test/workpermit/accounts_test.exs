defmodule Workpermit.UsersTest do
  use Workpermit.DataCase

  alias Workpermit.Users

  describe "users" do
    alias Workpermit.Users.User

    @valid_attrs %{
      email: "some email",
      password: "some password_hash",
      first_name: "some first_name",
      last_name: "some last_name",
      phone: "077123456"
    }
    @update_attrs %{
      email: "some updated email",
      password: "some updated password_hash",
      first_name: "some updated first_name",
      last_name: "some updated last_name",
      phone: "01111111111"
    }
    @invalid_attrs %{email: nil, password: nil, first_name: nil, last_name: nil, phone: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
      |> Map.drop([:password])
      |> Map.put(:password, nil)
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      user_list = Users.list_users()
      assert user in user_list
      assert length(user_list) > 0
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.password_hash != "some password_hash"
      assert user.password_hash =~ "$argon2"
      assert String.length(user.password_hash) == 98
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.phone == "077123456"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.password_hash != "some updated password_hash"
      assert user.password_hash =~ "$argon2"
      assert String.length(user.password_hash) == 98
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.phone == "01111111111"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end

  test "build_user/0 returns a user changeset" do
    assert %Ecto.Changeset{} = Users.build_user()
  end

  test "build_user/1 returns a user changeset with values applied" do
    attrs = %{"name" => "John"}
    changeset = Users.build_user(attrs)
    assert changeset.params == attrs
  end

  test "get_user" do
    valid_attrs = %{
      "last_name" => "John",
      "first_name" => "John",
      "email" => "john@example.com",
      "password" => "secret",
      "phone" => "1111"
    }

    {:ok, user1} = Users.create_user(valid_attrs)
    user2 = Users.get_by_credentials(valid_attrs)
    assert user1.id == user2.id
  end
end
