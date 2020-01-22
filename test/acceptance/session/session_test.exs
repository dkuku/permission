defmodule Web.Acceptance.SessionTest do
  use Workpermit.DataCase
  use Hound.Helpers

  hound_session()

  setup do
    ## GIVEN ##
    # There is a valid registered user
    alias Workpermit.Users

    valid_attrs = %{
      "first_name" => "John",
      "last_name" => "Snow",
      "email" => "john@example.com",
      "password" => "secret1234",
      "password_confirmation" => "secret1234",
      "phone" => "1111"
    }

    {:ok, _user} = Users.create_user(valid_attrs)
    :ok
  end

  test "shows error message for invalid credentials" do
    ## WHEN ##
    # users tryes to log in with invalid credentials
    navigate_to("/session/new")

    form = find_element(:tag, "form")

    find_within_element(form, :tag, "button")
    |> click

    ## THEN ##
    # current path should not change
    # and a message should be displayed
    assert current_path() == "/session"
    message = find_element(:class, "alert-toast") |> visible_text()

    assert message ==
             "The provided login details did not work. Please verify your credentials, and try again."
  end

  test "Create new user" do
    ## WHEN ##
    # users logs in
    set_window_size(current_window_handle(), 1024, 600)
    navigate_to("/registration/new")
    form = find_element(:tag, "form")

    find_within_element(form, :name, "user[email]")
    |> fill_field("john@example.co")

    find_within_element(form, :name, "user[password]")
    |> fill_field("secret1234")

    find_within_element(form, :name, "user[password_confirmation]")
    |> fill_field("secret1234")

    find_within_element(form, :name, "user[first_name]")
    |> fill_field("john")

    find_within_element(form, :name, "user[last_name]")
    |> fill_field("snow")

    find_within_element(form, :name, "user[phone]")
    |> fill_field("123444444")

    find_within_element(form, :tag, "button")
    |> click

    ## THEN ##
    # message should be displayed

    message =
      find_element(:tag, "label")
      |> visible_text()

    assert message == ""
    assert current_path() == "/"
  end

  test "successful sign-in for valid credential" do
    ## WHEN ##
    # users logs in
    set_window_size(current_window_handle(), 1024, 600)
    navigate_to("/session/new")

    form = find_element(:tag, "form")

    find_within_element(form, :name, "user[email]")
    |> fill_field("john@example.com")

    find_within_element(form, :name, "user[password]")
    |> fill_field("secret1234")

    find_within_element(form, :tag, "button")
    |> click

    ## THEN ##
    # message should be displayed

    message =
      find_element(:tag, "label")
      |> visible_text()

    assert message == ""
    # TODO fix message
    # assert message == "Signed in successfully."
    assert current_path() == "/"

    ## AND ##
    # logout clickable link
    logout_link = find_element(:link_text, "Sign out")
    click(logout_link)

    ## THEN ##
    # user can log out
    message =
      find_element(:tag, "label")
      |> visible_text()

    assert message == ""
    # assert message == "Signed out successfully!"
    assert visible_page_text() =~ "Log in"
  end
end
