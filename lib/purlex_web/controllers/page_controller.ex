defmodule PurlexWeb.PageController do
  use PurlexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
