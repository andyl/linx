defmodule LinxWeb.LinkForm do
  @moduledoc false

  use Phoenix.LiveView
  alias LinxWeb.UrlSchema
  import Phoenix.HTML.Form
  import LinxWeb.ErrorHelpers

  def mount(session, socket) do
    opts = %{
      changeset: UrlSchema.new_changeset(),
      url_host: session.url_host, 
      url_base: "",
      url_hash: ""
    }
    newsock = assign(socket, opts)
    IO.inspect "+++++++++++++++++++++++++++++++++++++++++++"
    IO.inspect newsock
    IO.inspect "+++++++++++++++++++++++++++++++++++++++++++"
    {:ok, newsock}
  end

  def render(assigns) do
    IO.inspect "=============================================="
    IO.inspect assigns
    IO.inspect "=============================================="
    ~L"""
    <%= f = form_for @changeset, "#", [phx_change: :validate, phx_submit: :save] %>

      <div class="form-group">
        <%= text_input f, :url, placeholder: "Enter your URL here...", class: "form-control" %>
        <%= error_tag f, :url %>
      </div>

      <%= if @changeset.valid? do %>
        <%= submit "Create a Short-URL", class: "btn btn-primary" %>
      <% else %>
        <button style='pointer-events: none;' class="btn btn-primary disabled">Create a Short-URL</button>
      <% end %>
    </form>

    <%= if @url_base != "" do %>
      <p style='margin-top: 40px;'>
      the short url<br/>
      <code><%= @url_host %>/<%= @url_hash %></code><br/>
      redirects to<br/>
      <code><%= @url_base %></code>
      </p>
      <p>
      try it...<br/>
      <a class="btn btn-primary" target="_blank" href="<%= @url_host %>/<%= @url_hash %>">
      <%= @url_host %>/<%= @url_hash %>
      </a>
    <% end %>
    """
  end

  def handle_event("validate", %{"url_schema" => opts}, socket) do
    changeset = 
      %UrlSchema{}
      |> UrlSchema.changeset(opts)
    opts = %{
      changeset: changeset,
      url_base: "",
      url_hash: ""
    }
    {:noreply, assign(socket, opts)}
  end

  def handle_event("save", %{"url_schema" => params}, socket) do
    url_base = params["url"]
    url_hash = Linx.Data.Link.create!(url_base)
    opts = %{
      url_base: url_base,
      url_hash: url_hash
    }
    {:noreply, assign(socket, opts)}
  end
end
