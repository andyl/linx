defmodule PurlexWeb.HomeController do
  use PurlexWeb, :controller

  def index(conn, _params) do
    conn
    |> assign(:url_host, Purlex.Url.conn_host(conn))
    |> render("index.html")
  end

  def urls(conn, _params) do
    all = 
      Purlex.Data.Link.all()
      |> Enum.map(&(elem(&1, 1)))
      |> Enum.sort(&(&1.url_host < &2.url_host))

    conn
    |> assign(:all, all)
    |> render("urls.html")
  end

  def logs(conn, _params) do
    all = 
      Purlex.Data.Log.all()
      |> Enum.map(&(elem(&1, 1)))
      # |> Enum.sort(&(&1.ts_used_at > &2.ts_used_at))

    conn
    |> assign(:all, all)
    |> render("logs.html")
  end

  def stats(conn, _params) do
    render(conn, "stats.html")
  end

  def key_direct(conn, params) do
    key = params["key"]
    url = Purlex.Data.Link.lookup(key)

    if url != nil do
      Purlex.Data.Log.record(url)
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
