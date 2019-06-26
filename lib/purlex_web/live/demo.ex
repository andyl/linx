defmodule PurlexWeb.Demo do
  use Phoenix.LiveView
  use Timex
  alias PurlexWeb.DemoView

  def render(assigns) do
    DemoView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    :timer.send_interval(10000, self(), :tick)
    {:ok, assign(socket, val: 0, query: nil, changed: false, date: ldate())}
  end

  def handle_info(:tick, socket) do
    {:noreply, update(socket, :date, fn (_) -> ldate() end)}
  end

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :val, &(&1 + 1))}
  end

  def handle_event("dec", _, socket) do
    {:noreply, update(socket, :val, &(&1 - 1))}
  end

  def handle_event("validate", arg, socket) do
    eval = fn(_) -> String.length(arg["q"]) > 0 end
    {:noreply, update(socket, :changed, eval)}
  end

  def handle_event("save", arg, socket) do
    {:noreply, socket}
  end

  defp ldate do
    Timex.now("US/Pacific")
    |> Timex.format!("%d %b %H:%M", :strftime)
  end
end
