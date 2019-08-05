defmodule PurlexWeb.HomeController do
  use PurlexWeb, :controller

  def index(conn, _params) do
    conn
    |> assign(:url_host, Purlex.Url.conn_host(conn))
    |> render("index.html")
  end

  def urls(conn, _params) do
    render(conn, "urls.html")
  end

  def logs(conn, _params) do
    render(conn, "logs.html")
  end

  def stats(conn, _params) do
    render(conn, "stats.html")
  end

  def key_direct(conn, params) do
    key = params["key"]
    url = Purlex.Data.Link.lookup(key)
    if url != nil do
      conn
      |> redirect(external: url.url_base)
    else
      conn
      |> put_flash(:error, "Short-URL key (#{key}) not found.")
      |> assign(:url_host, Purlex.Url.conn_host(conn))
      |> redirect(to: "/")
    end
  end
end
