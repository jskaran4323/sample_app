defmodule SampleAppWeb.StaticPageControllerTest do
  use SampleAppWeb.ConnCase

   @base_title "Phoenix Tutorial Sample App"
     test "should get home", %{conn: conn} do
    conn = get(conn, Routes.static_page_path(conn, :home))

    assert html_response(conn, 200) =~ "title", "Home | #{@base_title}</title>"
   end

  test "should get help", %{conn: conn} do
    conn= conn |> get(Routes.static_page_path(conn, :help))
  assert html_response(conn, 200) =~ "title", "Help | Phoenix Tutorial Sample App</title>"

  end
  test "should get about" , %{conn: conn} do
    conn=conn |> get(Routes.static_page_path(conn,:about))
   assert html_response(conn, 200) =~ "title", "About | Phoenix Tutorial Sample App"
   end

end
