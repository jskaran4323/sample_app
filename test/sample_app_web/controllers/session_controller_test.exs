defmodule SampleAppWeb.SessionControllerTest do
  use SampleAppWeb.ConnCase, async: true

  test "renders the login page", %{conn: conn} do
    conn = get(conn, ~p"/login") # Using the path helper for login defined in your routes
    assert html_response(conn, 200) =~ "Log in | Phoenix Tutorial Sample App"
  end
end
