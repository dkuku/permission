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
      "password" => "secret",
      "phone" => "1111"
    }

    {:ok, _} = Users.create_user(valid_attrs)
    :ok
  end

  test "successful sign-in for valid credential" do
    ## WHEN ##
    # users logs in
    set_window_size(current_window_handle(), 1024, 600)
    navigate_to("/sign-in")

    form = find_element(:tag, "form")

    find_within_element(form, :name, "session[email]")
    |> fill_field("john@example.com")

    find_within_element(form, :name, "session[password]")
    |> fill_field("secret")

    find_within_element(form, :tag, "button")
    |> click

    ## THEN ##
    # message should be displayed
    assert current_path() == "/"

    message =
      find_element(:tag, "label")
      |> visible_text()

    assert message == "Signed in successfully."

    ## AND ##
    # logout clickable link
    logout_link = find_element(:link_text, "Sign out")
    click(logout_link)

    ## THEN ##
    # user can log out
    message =
      find_element(:tag, "label")
      |> visible_text()

    assert message == "Signed out successfully!"
    assert visible_page_text() =~ "Log in"
  end

  test "shows error message for invalid credentials" do
    ## WHEN ##
    # users tryes to log in with invalid credentials
    navigate_to("/sign-in")

    form = find_element(:tag, "form")

    find_within_element(form, :tag, "button")
    |> click

    ## THEN ##
    # current path should not change
    # and a message should be displayed
    assert current_path() == "/sign-in"
    message = find_element(:class, "alert-toast") |> visible_text()
    assert message == "There was a problem with your username/password."
  end
end
