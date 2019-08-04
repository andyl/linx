defmodule PurlexWeb.LinkForm do
  use Phoenix.LiveView
  use Timex

  def mount(_session, socket) do
    {:ok, assign(socket, %{})}
  end

  def render(assigns) do
    ~L"""
    <form phx-change="update_text">
      <input type="text" name="input_url" placeholder="Enter URL..." /></input> <br/>
      <input type="text" name="alias" placeholder="Enter Alias (optional)..." /></input> 
    </form>
    """
  end

  # def handle_info(:tick, socket) do
  #   {:noreply, update(socket, :date, fn (_) -> ldate() end)}
  # end
  #
  # defp ldate do
  #   Timex.now("US/Pacific")
  #   |> Timex.format!("%d %b %H:%M", :strftime)
  # end
end
