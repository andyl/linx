defmodule LinkexWeb.PageControllerTest do
  use LinkexWeb.ConnCase

  test "GET /page", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Linkex"
  end
end
