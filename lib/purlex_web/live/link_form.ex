defmodule PurlexWeb.LinkForm do
  use Phoenix.LiveView
  alias PurlexWeb.UrlSchema
  import Phoenix.HTML.Form
  import PurlexWeb.ErrorHelpers

  def mount(_session, socket) do
    {:ok, assign(socket, %{changeset: UrlSchema.new_changeset()})}
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
      <div class="form-group">
        <%= text_input f, :alt, placeholder: "Alias", class: "form-control" %>
        <%= error_tag f, :alt %>
      </div>
      <%= if @changeset.valid? do %>
        <%= submit "Save", class: "btn btn-primary", phx_disable_with: "Saving..." %>
      <% else %>
        <button style='pointer-events: none;' class="btn btn-primary disabled">Save</button>
      <% end %>
    </form>
    """
  end

  def handle_event("validate", %{"url_schema" => opts}, socket) do
    changeset = 
      %UrlSchema{}
      |> UrlSchema.changeset(opts)
    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", var2, socket) do
    # IO.puts "===================================================="
    # IO.inspect var2
    # IO.puts "===================================================="
    # IO.inspect socket
    # IO.puts "===================================================="

    {:noreply, socket}
  end

  # def handle_event("validate", %{"user" => params}, socket) do
  #   io.puts "===================================================="
  #   io.puts "===================================================="
  #   changeset =
  #     %User{}
  #     |> Accounts.change_user(params)
  #     |> Map.put(:action, :insert)
  #
  #   {:noreply, assign(socket, changeset: changeset)}
  # end

  # def handle_event("save", %{"user" => user_params}, socket) do
  #   IO.puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  #   IO.puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  #   case Accounts.create_user(user_params) do
  #     {:ok, user} ->
  #       {:stop,
  #        socket
  #        |> put_flash(:info, "User created successfully.")
  #        |> redirect(to: Routes.live_path(socket, UserLive.Show, user))}
  #
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign(socket, changeset: changeset)}
  #   end
  # end

end
