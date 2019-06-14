defmodule PurlexWeb.PageControllerTest do
  use PurlexWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Purlex"
  end
end
