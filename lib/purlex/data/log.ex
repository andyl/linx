defmodule Purlex.Data.Log do
  @ctx %{filepath: "/tmp/logstore.dat", tablekey: :logs}

  defstruct [:base_url, :hash_url, :ts_used_at, :use_count]

  alias Purlex.Data.Log

  @moduledoc """
  Manage access logs.

  We record a single event payload every time a link is accessed.

  Payload elements:
  - base_url - the long url
  - hash_url - the short url
  - ts_used_at - the time that the link is used
  - use_count - number of times that the link is used
  """

  @doc """
  Record an access event.

  Every time a link is accesses, save an event-payload into the log-store.
  """
  def record(link, ctx \\ @ctx) do
    start_data_store(ctx)
    payload = %Log{
      base_url: link.base_url,
      hash_url: link.hash_url,
      ts_used_at: link.ts_used_at,
      use_count: link.use_count
    }
    Pets.insert(link.hash_url, payload)
  end

  @doc """
  Return all event-payloads for a given hash_url.
  """
  def lookup(hash_url, ctx \\ @ctx) do
    start_data_store(ctx)
    Pets.lookup(ctx.tablekey, hash_url)
  end

  defp start_data_store(ctx) do
    unless Pets.started?(ctx.tablekey),
      do: Pets.start(ctx.tablekey, ctx.filepath, [:bag])
  end
end
