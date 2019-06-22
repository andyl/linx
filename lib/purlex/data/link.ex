defmodule Purlex.Data.Link do
  @ctx %{filepath: "/tmp/linkstore.dat", tablekey: :links}

  defstruct [:address_base, :address_hash, :ts_creation, :ts_last_use, :use_count]

  alias Purlex.Data.GenStore
  alias Purlex.Data.Link

  @moduledoc """
  Manage links.

  We record a single record for each URL in the system.

  Payload elements:
  - address_base - the input address
  - address_hash - the address hash
  - ts_creation - timestamp of the hash creation
  - ts_last_use - timestamp of last lookup
  - use_count - number of lookups

  The address_hash is used as the lookup key to retrieve the payload from the
  datastore.  
  """

  @doc """
  Create link payload, save in datastore, return the address_hash.
  """
  def create(address_base, ctx \\ @ctx) do
    address_base
    |> create_payload()
    |> save_payload(ctx)
  end

  @doc """
  Lookup the address_hash, update the use_count, return link payload.
  """
  def lookup(address_hash, ctx \\ @ctx) do
    get_payload(address_hash, ctx)
    |> update_payload(ctx)
  end

  defp create_payload(address_base) do
    time_now = DateTime.utc_now()

    %Link{
      address_base: address_base,
      address_hash: hash(address_base),
      ts_creation: time_now,
      ts_last_use: time_now,
      use_count: 0
    }
  end

  defp hash(string) do
    :md5
    |> :crypto.hash(string)
    |> Base.url_encode64(padding: false)
    |> String.slice(1..6)
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
    GenStore.insert(ctx.tablekey, {payload.address_hash, payload})
    payload.address_hash
  end

  defp update_payload(payload, ctx) do
    update = with date <- DateTime.utc_now(),
         count <- payload.use_count + 1, do:
      %Link{payload | ts_last_use: date, use_count: count}
    GenStore.insert(ctx.tablekey, {update.address_hash, update})
    update
  end
end
