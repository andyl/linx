defmodule LinxWeb.PageControllerTest do
  use LinxWeb.ConnCase

  test "GET /page", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Linx"
  end
end
