defmodule PurlexWeb.LayoutView do
  use PurlexWeb, :view

  def hdr_link(conn, lbl, path) do
    ~e"""
    <li class="nav-item">
      <%= active_link(conn, lbl, to: path, active_class: "nav-item active", inactive_class: "nav-item") %>
    </li>
    """
  end
end
