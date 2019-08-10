defmodule Purlex.Data.Log do

  defstruct [
    :url_hash, 
    :url_base, 
    :url_host, 
    :ts_used_at, 
    :use_count
  ]

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
  def record(link) do
    payload = %Log{
      url_hash: link.url_hash,
      url_base: link.url_base,
      url_host: link.url_host,
      ts_used_at: DateTime.utc_now(),
      use_count: link.use_count
    }
    sig()
    |> Pets.insert({payload.ts_used_at, payload})
  end

  @doc """
  Return all event-payloads for a given hash_url.
  """
  def lookup(hash_url) do
    sig()
    |> Pets.lookup(hash_url)
  end

  @doc """
  Return all records.
  """
  def all do
    sig()
    |> Pets.all()
  end

  @env Mix.env()
  defp sig do
    case @env do
      :dev  -> %{filepath: "/tmp/log_dev.dat",  tablekey: :log_dev}
      :test -> %{filepath: "/tmp/log_test.dat", tablekey: :log_test}
      :prod -> %{filepath: "/tmp/log_prod.dat", tablekey: :log_prod}
    end
  end
end
