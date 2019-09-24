defmodule LinkexWeb.HomeControllerTest do
  use LinkexWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Linkex"
  end

  test "GET /urls", %{conn: conn} do
    conn = get(conn, "/urls")
    assert html_response(conn, 200) =~ "URLS"
  end

  test "GET /logs", %{conn: conn} do
    conn = get(conn, "/logs")
    assert html_response(conn, 200) =~ "LOGS"
  end

  test "GET /stats", %{conn: conn} do
    conn = get(conn, "/stats")
    assert html_response(conn, 200) =~ "STATS"
  end
end
