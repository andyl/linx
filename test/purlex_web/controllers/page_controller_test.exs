defmodule PurlexWeb.PageControllerTest do
  use PurlexWeb.ConnCase

  test "GET /page", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Purlex"
  end
end
