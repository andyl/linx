defmodule PurlexWeb.LinkForm do
  use Phoenix.LiveView
  alias PurlexWeb.UrlSchema
  import Phoenix.HTML.Form
  import PurlexWeb.ErrorHelpers

  def mount(session, socket) do
    opts = %{
      changeset: UrlSchema.new_changeset(),
      url_host: session.url_host, 
      url_base: "",
      url_hash: ""
    }
    {:ok, assign(socket, opts)}
  end

  def render(assigns) do
    ~L"""
    <%= f = form_for @changeset, "#", [phx_change: :validate, phx_submit: :save] %>
    
      <%= if @changeset.action do %>
        <div class="alert alert-danger">
          Something went wrong! Please check the errors below.
        </div>
      <% end %>

      <div class="form-group">
        <%= text_input f, :url, placeholder: "URL", class: "form-control" %>
        <%= error_tag f, :url %>
      </div>

      <%= if @changeset.valid? do %>
        <%= submit "Create", class: "btn btn-primary", phx_disable_with: "Saving..." %>
      <% else %>
        <button style='pointer-events: none;' class="btn btn-primary disabled">Create</button>
      <% end %>
    </form>

    <%= if @url_base != "" do %>
      <p style='margin-top: 40px;'>
      the short url<br/>
      <code><%= @url_host %>/<%= @url_hash %></code><br/>
      redirects to<br/>
      <code><%= @url_base %></code>
      </p>
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
    url_hash = Purlex.Data.Link.create!(url_base)
    opts = %{
      url_base: url_base,
      url_hash: url_hash
    }
    {:noreply, assign(socket, opts)}
  end
end
