defmodule SampleAppWeb.PageControllerTest do
  use SampleAppWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "hello world!"
  end


  

end
