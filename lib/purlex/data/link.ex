defmodule Purlex.Data.Link do
  @ctx %{filepath: "/tmp/linkstore.dat", tablekey: :links}
  @url "http://mysite.com/"

  defstruct [:base_url, :hash_url, :ts_creation, :ts_last_use, :use_count]

  alias Purlex.Data.GenStore
  alias Purlex.Data.Link

  @moduledoc """
  Manage links.

  We record a single record for each URL in the system.

  Payload elements:
  - base_url - the input url
  - hash_url - the shortened url
  - ts_creation - timestamp of the link creation
  - ts_last_use - timestamp of last lookup
  - use_count - number of lookups

  The hash_url is used as the lookup key to retrieve the payload from the
  datastore.  
  """

  @doc """
  Create link payload, save in datastore, return the hash_url.
  """
  def create(base_url, ctx \\ @ctx) do
    base_url
    |> create_payload()
    |> save_payload(ctx)
  end

  @doc """
  Lookup the hash_url, update the use_count, return link payload.
  """
  def lookup(hash_url, ctx \\ @ctx) do
    get_payload(hash_url, ctx)
    |> update_payload(ctx)
  end

  defp create_payload(base_url) do
    time_now = DateTime.utc_now()

    %Link{
      base_url: base_url,
      hash_url: @url <> hash(base_url),
      ts_creation: time_now,
      ts_last_use: time_now,
      use_count: 0
    }
  end

  defp hash(string) do
    :md5
    |> :crypto.hash(string)
    |> Base.url_encode64(padding: false)
    |> String.slice(1..5)
  end

  defp start_data_store(ctx) do
    unless GenStore.started?(ctx.tablekey),
      do: GenStore.start(ctx.tablekey, ctx.filepath)
  end

  defp get_payload(datakey, ctx) do
    start_data_store(ctx)

    GenStore.lookup(ctx.tablekey, datakey)
    |> List.first()
    |> elem(1)
  end

  defp save_payload(payload, ctx) do
    start_data_store(ctx)
    GenStore.insert(ctx.tablekey, {payload.hash_url, payload})
    payload.hash_url
  end

  defp update_payload(payload, ctx) do
    update = with date <- DateTime.utc_now(),
         count <- payload.use_count + 1, do:
      %Link{payload | ts_last_use: date, use_count: count}
    GenStore.insert(ctx.tablekey, {update.hash_url, update})
    update
  end
end
