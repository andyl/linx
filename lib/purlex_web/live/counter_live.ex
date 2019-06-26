defmodule PurlexWeb.CounterLive do
  use Phoenix.LiveView
  alias PurlexWeb.CounterView

  def render(assigns) do
    CounterView.render("index.html", assigns)
  end

  def mount(_session, socket) do
    :timer.send_interval(1000, self(), :tick)
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

  def handle_event("suggest", arg, socket) do
    IO.inspect arg
    {:noreply, update(socket, :changed, fn (_) -> String.length(arg["q"]) > 0 end)}
  end

  defp ldate do
    NaiveDateTime.utc_now()
    |> NaiveDateTime.to_string()
    |> String.split(".")
    |> List.first()
    |> (&<>/2).("Z")
  end
end
