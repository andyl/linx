defmodule LinxWeb.SessionPlug do
  import Plug.Conn

  @doc """
  Set the url_host value
  """
  def set_url_host(conn, _opts) do
    conn
    |> put_session(:url_host, Linx.Url.conn_host(conn))
  end
end
