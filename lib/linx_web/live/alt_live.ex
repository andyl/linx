defmodule LinxWeb.AltLive do
  use LinxWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <section class="container mx-auto py-24 px-4">
    HELLO ALT WORLD 
    </section>
    """
  end
end
