defmodule Purlex.Data.Log do
  @ctx %{filepath: "/tmp/logstore.dat", tablekey: :logs}

  defstruct [:url_hash, :url_base, :url_host, :ts_used_at, :use_count]

  alias Purlex.Data.Log

  @moduledoc """
  Manage access logs.

  We record a single event payload every time a link is accessed.

  Payload elements:
  - url_base - the long url
  - url_hash - the short url
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
      url_hash: link.url_hash,
      url_base: link.url_base,
      url_host: link.url_host,
      ts_used_at: DateTime.utc_now(),
      use_count: link.use_count
    }
    Pets.insert(ctx.tablekey, {payload.ts_used_at, payload})
  end

  @doc """
  Return all event-payloads for a given hash_url.
  """
  def lookup(hash_url, ctx \\ @ctx) do
    start_data_store(ctx)
    Pets.lookup(ctx.tablekey, hash_url)
  end

  @doc """
  Return all records.
  """
  def all(ctx \\ @ctx) do
    start_data_store(ctx)
    Pets.all(ctx.tablekey)
  end

  defp start_data_store(ctx) do
    unless Pets.started?(ctx.tablekey),
      do: Pets.start(ctx.tablekey, ctx.filepath, [:ordered_set])
  end
end
