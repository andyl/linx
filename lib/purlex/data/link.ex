defmodule Purlex.Data.Link do
  @ctx %{filepath: "/tmp/linkstore.dat", tablekey: :links}

  defstruct [:url_base, :url_hash, :url_host, :ts_creation, :ts_last_use, :use_count]

  alias Purlex.Data.Link

  @moduledoc """
  Manage links.

  We record a single record for each URL in the system.

  Payload elements:
  - url_base - the input url
  - url_hash - the url hash
  - url_host - the input url host
  - ts_creation - timestamp of the hash creation
  - ts_last_use - timestamp of last lookup
  - use_count - number of lookups

  The url_hash is used as the lookup key to retrieve the payload from the
  datastore.  
  """

  @doc """
  Create link payload, save in datastore, return the url_hash.
  """
  def create(url_base, ctx \\ @ctx) do
    if valid_url?(url_base) do
      {:ok, create!(url_base, ctx)}
    else
      {:error, "Invalid URL"}
    end
  end

  @doc """
  Create link payload, save in datastore, return the url_hash.
  """
  def create!(url_base, ctx \\ @ctx) do
    payload = create_payload(url_base)
    if has_key?(payload.url_hash, ctx) do
      payload.url_hash
    else
      save_payload(payload, ctx)
    end
  end

  @doc """
  Lookup the url_hash, update the use_count, return link payload.
  """
  def lookup(url_hash, ctx \\ @ctx) do
    if has_key?(url_hash, ctx) do
      get_payload(url_hash, ctx)
      |> update_payload(ctx)
    else
      nil
    end
  end

  @doc """
  Return all records.
  """
  def all(ctx \\ @ctx) do
    start_data_store(ctx)
    Pets.all(ctx.tablekey)
  end

  defp create_payload(url_base) do
    key = hash(url_base)
    time_now = DateTime.utc_now()

    %Link{
      url_base: url_base,
      url_hash: key,
      url_host: URI.parse(url_base).host,
      ts_creation: time_now,
      ts_last_use: time_now,
      use_count: 0
    }
  end

  defp valid_url?(url) do
    Purlex.Url.regex()
    |> Regex.match?(url)
  end

  defp hash(string) do
    :md5
    |> :crypto.hash(string)
    |> Base.url_encode64(padding: false)
    |> String.slice(1..6)
  end

  defp has_key?(datakey, ctx) do
    start_data_store(ctx)
    Pets.has_key?(ctx.tablekey, datakey)
  end

  defp start_data_store(ctx) do
    unless Pets.started?(ctx.tablekey),
      do: Pets.start(ctx.tablekey, ctx.filepath)
  end

  defp get_payload(datakey, ctx) do
    start_data_store(ctx)

    Pets.lookup(ctx.tablekey, datakey)
    |> List.first()
    |> elem(1)
  end

  defp save_payload(payload, ctx) do
    start_data_store(ctx)
    Pets.insert(ctx.tablekey, {payload.url_hash, payload})
    payload.url_hash
  end

  defp update_payload(payload, ctx) do
    update =
      with date <- DateTime.utc_now(),
           count <- payload.use_count + 1,
           do: %Link{payload | ts_last_use: date, use_count: count}

    Pets.insert(ctx.tablekey, {update.url_hash, update})
    update
  end
end
