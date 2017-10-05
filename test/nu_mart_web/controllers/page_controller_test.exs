defmodule NuMartWeb.PageControllerTest do
  use NuMartWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 302)
  end
end
