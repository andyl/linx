defmodule Linx.Url do
  def regex do
    ~r/https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)/
  end

  def conn_host(conn) do
    con_port = if "#{conn.port}" == "", do: "", else: ":#{conn.port}"
    "#{conn.scheme}://#{conn.host}#{con_port}"
  end
end
